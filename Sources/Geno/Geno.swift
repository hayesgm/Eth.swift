
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

// Create the struct declaration syntax
func createSourceFileSyntax(from contract: Contract, name: String) -> SourceFileSyntax {
    return SourceFileSyntax {
        try! ImportDeclSyntax("import Foundation").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import BigInt").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import Eth").with(\.trailingTrivia, .newline)

        try! StructDeclSyntax(leadingTrivia: .newline, name: .identifier(name, leadingTrivia: .space)) {
            for s in generateStructs(c: contract) {
                s
            }

            try VariableDeclSyntax("static let bytecode: Data = Hex.parseHex(\"\(raw: contract.bytecode.object)\")!").with(\.trailingTrivia, .newline)
            try VariableDeclSyntax("static let deployedBytecode: Data = Hex.parseHex(\"\(raw: contract.deployedBytecode.object)\")!").with(\.trailingTrivia, .newlines(2))

            // Generate a swift function and {ETH.ABI.Function} for each ABI function
            for function in contract.abi {
                generateETHABIFunction(f: function)
                generateFunctionDeclaration(f: function)
            }
        }
    }
}

func generateETHABIFunction(f: Contract.ABI.Function) -> VariableDeclSyntax {
    func mapToETHABITypes(_ ps: [Contract.ABI.Function.Parameter]) -> DeclSyntax {
        let out: String = ps.map { parameterToFieldType(p: $0) }.joined(separator: ", ")

        return DeclSyntax("\(raw: out)")
    }

    return try! VariableDeclSyntax("""
    static let \(raw: f.name)Fn = ABI.Function(
            name: "\(raw: f.name)",
            inputs: [\(raw: mapToETHABITypes(f.inputs))],
            outputs: [\(raw: mapToETHABITypes(f.outputs))]
    )
    """)
    .with(\.trailingTrivia, .newline)
}

func generateFunctionDeclaration(f: Contract.ABI.Function) -> FunctionDeclSyntax {
    let parameters = functionParameters(f: f)
    let outputs = returnValue(f: f)

    return try! FunctionDeclSyntax("""
    static func \(raw: f.name)(\(raw: parameters.joined(separator: ", "))) throws -> \(raw: outputs)
    """) {
        StmtSyntax("""

                let query = try \(raw: f.name)Fn.encoded(with: [\(raw: callParameters(f: f))])
                let result = try EVM.runQuery(bytecode: deployedBytecode, query: query)
                let decoded = try \(raw: f.name)Fn.decode(output: result)

                let oot : \(raw: outputs)
                switch decoded {
                case let \(raw: outParameters(f: f)):
                    oot = \(raw: outValues(f: f))
                default:
                    throw ABI.FunctionError.unexpectedError("invalid decode")
                }

                return oot
        """)
    }
    .with(\.leadingTrivia, .newline)
    .with(\.trailingTrivia, .newlines(2))
}

func outValues(f: Contract.ABI.Function) -> String {
    f.outputs.enumerated().map { index, p in
        switch p.type {
        case let arrayType where arrayType.contains("[]"):
            let arrayContents = arrayType.replacingOccurrences(of: "[]", with: "")
            if arrayContents == "tuple" {
                let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: i) }
                return ".array(.tuple([\(componentTypes.joined(separator: ", "))]))"
            } else {
                return ".array(\(arrayContents))"
            }
        case "tuple":
            if p.internalType.starts(with: "struct") {
                return structInitializer(p: p)
            } else {
                let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: i) }
                return "(\(componentTypes.joined(separator: ", ")))"
            }
        default:
            return nameOrNot(p: p, index: index)
        }
    }.joined(separator: ", ")
}

func namedParameterToOutValue(p: Contract.ABI.Function.Parameter) -> String {
    switch p.type {
    case let arrayType where arrayType.contains("[]"):
        let arrayContents = arrayType.replacingOccurrences(of: "[]", with: "")
        if arrayContents == "tuple" {
            let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: i) }
            return ".array(.tuple([\(componentTypes.joined(separator: ", "))]))"
        } else {
            return ".array(\(arrayContents))"
        }
    case "tuple":
        if p.internalType.starts(with: "struct") {
            return structInitializer(p: p)
        } else {
            let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: i) }
            return "(\(componentTypes.joined(separator: ", ")))"
        }
    default:
        return nameOrNot(p: p, index: 0)
    }
}

func structInitializer(p: Contract.ABI.Function.Parameter) -> String {
    if let c = p.components {
        let structName = p.internalType.replacingOccurrences(of: "struct ", with: "")
        let args = c.map { "\($0.name): \($0.name)" }.joined(separator: ", ")
        return "\(structName)(\(args))"
    } else {
        return p.name
    }
}

func outParameters(f: Contract.ABI.Function) -> String {
    return f.outputs.enumerated().map { index, o in
        parameterToMatchableFieldType(p: o, index: index)
    }.joined(separator: ", ")
}

func callParameters(f: Contract.ABI.Function) -> String {
    return f.inputs.map { "\(parameterToFieldType(p: $0))(\($0.name))" }.joined(separator: ", ")
}

func functionParameters(f: Contract.ABI.Function) -> [String] {
    return f.inputs.map { "\($0.name): \(try! typeMapper(for: $0.internalType))" }
}

func returnValue(f: Contract.ABI.Function) -> String {
    f.outputs.map { try! typeMapper(for: $0.internalType) }.joined(separator: ", ")
}

func parameterToFieldType(p: Contract.ABI.Function.Parameter) -> String {
    switch p.type {
    case let arrayType where arrayType.contains("[]"):
        let arrayContents = arrayType.replacingOccurrences(of: "[]", with: "")
        if arrayContents == "tuple" {
            let componentTypes = p.components?.map { parameterToFieldType(p: $0) } ?? []
            return ".array(.tuple([\(componentTypes.joined(separator: ", "))]))"
        } else {
            return ".array(\(arrayContents))"
        }
    case "tuple":
        let componentTypes = p.components?.map { parameterToFieldType(p: $0) } ?? []
        return ".tuple([\(componentTypes.joined(separator: ", "))])"
    default:
        // low key turning them into the enum values
        return ".\(p.type)"
    }
}

func parameterToMatchableFieldType(p: Contract.ABI.Function.Parameter, index: Int) -> String {
    let name = nameOrNot(p: p, index: index)
    switch p.type {
    case let arrayType where arrayType.contains("[]"):
        let arrayContents = arrayType.replacingOccurrences(of: "[]", with: "")
        if arrayContents == "tuple" {
            let componentTypes = p.components!.enumerated().map { _, p in parameterToFieldType(p: p) }
            return ".array(.tuple([\(componentTypes.joined(separator: ", "))]), \(name))"
        } else {
            return ".array(\(arrayContents), \(name))"
        }
    case "tuple":
        let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: index * 10 + i) }
        return ".tuple\(componentTypes.count)(\(componentTypes.joined(separator: ", ")))"
    default:
        // turning them into the enum values, with named values
        return ".\(p.type)(\(name))"
    }
}

func nameOrNot(p: Contract.ABI.Function.Parameter, index: Int) -> String {
    return if p.name.isEmpty {
        "out\(index)"
    } else {
        p.name
    }
}

func typeMapper(for t: String) throws -> String {
    switch t {
    case "bool":
        return "Bool"
    case "string":
        return "String"
    case "address", "address payable":
        return "String"
    case "tuple":
        return "tuple"
    case let arrayType where arrayType.hasSuffix("[]"):
        let elementType = arrayType.replacingOccurrences(of: "[]", with: "")
        return "[\(try! typeMapper(for: elementType))]"
    case let type where type.starts(with: "uint"):
        return "BigUInt"
    case let type where type.starts(with: "int"):
        return "BigInt"
    case let bytesType where bytesType.starts(with: "bytes"):
        return "Data" // Dynamically-sized bytes sequence.
    case let structType where structType.starts(with: "struct"):
        return structType.replacingOccurrences(of: "struct ", with: "")
    default:
        throw NSError(domain: "TypeMapperError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unsupported type: \(t)"])
    }
}

func generateAbiFile(input_path: URL) -> String {
    let data = try! Data(contentsOf: input_path)
    let contract = try! JSONDecoder().decode(Contract.self, from: data)

    // Create the struct syntax node
    let structNode = createSourceFileSyntax(from: contract, name: String(input_path.lastPathComponent.split(separator: ".").first!))

    // Generate source code from the syntax node
    let sourceCode = structNode.formatted().description

    var text = ""
    sourceCode.write(to: &text)
    return text
}

func generateStructs(c: Contract) -> [StructDeclSyntax] {
    var structsSoFar: [String: StructDeclSyntax] = [:]
    for f in c.abi {
        for i in f.inputs {
            _ = makeStruccs(i, struccs: &structsSoFar)
        }

        for o in f.outputs {
            _ = makeStruccs(o, struccs: &structsSoFar)
        }
    }
    return Array(structsSoFar.values)
}

func makeStruccs(_ p: Contract.ABI.Function.Parameter, struccs: inout [String: StructDeclSyntax]) -> [String: StructDeclSyntax] {
    if p.internalType.starts(with: "struct") {
        let def = try! StructDeclSyntax(leadingTrivia: .newline, name: .identifier(p.internalType.replacingOccurrences(of: "struct ", with: ""), leadingTrivia: .space)) {
            try VariableDeclSyntax("static let schema: ABI.Schema = \(raw: parameterToFieldType(p: p))")

            for c in p.components! {
                try VariableDeclSyntax("let \(raw: c.name): \(raw: typeMapper(for: c.internalType))")
            }

            try VariableDeclSyntax("var encoded: Data { asField.encoded }").with(\.trailingTrivia, .newlines(2))
            try VariableDeclSyntax("var asField: ABI.Field { \(raw: parameterToMatchableFieldType(p: p, index: 0)) }").with(\.trailingTrivia, .newlines(2))

            try! FunctionDeclSyntax("""
            static func decode(data: Data) throws -> \(raw: typeMapper(for: p.internalType))
            """) {
                StmtSyntax("""
                let decoded = try schema.decode(data)
                switch decoded {
                case let \(raw: parameterToMatchableFieldType(p: p, index: 0)):
                    return \(raw: namedParameterToOutValue(p: p))
                default:
                    throw ABI.FunctionError.unexpectedError("invalid decode")
                }
                """)

            }.with(\.trailingTrivia, .newlines(2))
                .with(\.leadingTrivia, .newlines(2))
        }
        struccs[p.internalType] = def
    }
    return struccs
}
