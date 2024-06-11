
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

            try VariableDeclSyntax("static let creationCode: Data = Hex.parseHex(\"\(raw: contract.bytecode.object)\")!").with(\.trailingTrivia, .newline)
            try VariableDeclSyntax("static let runtimeCode: Data = Hex.parseHex(\"\(raw: contract.deployedBytecode.object)\")!").with(\.trailingTrivia, .newlines(2))

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
        let out: String = ps.map { parameterToFieldType($0) }.joined(separator: ", ")

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
                let result = try EVM.runQuery(bytecode: runtimeCode, query: query)
                let decoded = try \(raw: f.name)Fn.decode(output: result)

                let oot : \(raw: outputs)
                switch decoded {
                case let \(raw: outParameters(f: f)):
                    oot = \(raw: outValues(f: f))
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.fieldType, \(raw: f.name)Fn.outputTuple)
                }

                return oot
        """)
    }
    .with(\.leadingTrivia, .newline)
    .with(\.trailingTrivia, .newlines(2))
}

func outValues(f: Contract.ABI.Function) -> String {
    f.outputs.enumerated().map { index, p in
        namedParameterToOutValue(p: p, index: index)
    }.joined(separator: ", ")
}

func namedParameterToOutValue(p: Contract.ABI.Function.Parameter, index: Int) -> String {
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
        if let structName = structName(p) {
            return structInitializer(parameter: p, structName: structName)
        } else {
            let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: i) }
            return "(\(componentTypes.joined(separator: ", ")))"
        }
    default:
        return parameterVar(parameter: p, index: index, withPrefix: "var")
    }
}

func fieldValue(parameter: Contract.ABI.Function.Parameter, index _: Int) -> String {
    if isArray(parameter) {
        // TODO: check struct
        return "\(parameter.name).map { \(try! asFieldMapper(parameter: parameter)) }"
    } else {
        return parameter.name
    }
}

func structInitializer(parameter p: Contract.ABI.Function.Parameter, structName: String) -> String {
    if let c = p.components {
        let args = c.enumerated().map { "\($0.1.name): \(fieldValue(parameter: $0.1, index: $0.0))" }.joined(separator: ", ")
        return "try \(structName)(\(args))"
    } else {
        return p.name
    }
}

func outParameters(f: Contract.ABI.Function) -> String {
    let inner = f.outputs.enumerated().map { index, o in
        parameterToMatchableFieldType(p: o, index: index)
    }.joined(separator: ", ")

    guard f.outputs.count <= 16 else {
        // TODO: Handle N-sized tuples
        fatalError("Geno cannot decode tuples with more than 16 fields")
    }
    return ".tuple\(f.outputs.count)(\(inner))"
}

func callParameters(f: Contract.ABI.Function) -> String {
    return f.inputs.map { parameter in
        if let structName = structName(parameter) {
            "\(parameter.name).asField"
        } else {
            "\(parameterToFieldType(parameter, allowSchema: true))(\(parameter.name))"
        }
    }.joined(separator: ", ")
}

func functionParameters(f: Contract.ABI.Function) -> [String] {
    return f.inputs.map { "\($0.name): \(try! typeMapper(for: $0.internalType))" }
}

func returnValue(f: Contract.ABI.Function) -> String {
    f.outputs.map { try! typeMapper(for: $0.internalType) }.joined(separator: ", ")
}

func parameterToFieldType(_ parameter: Contract.ABI.Function.Parameter, allowSchema: Bool = false) -> String {
    let inner: String
    let baseParameter = baseParameter(parameter)

    if isTuple(parameter) {
        if allowSchema, let structName = structName(parameter) {
            inner = "\(structName).schema"
        } else {
            let componentTypes = parameter.components?.map { parameterToFieldType($0, allowSchema: true) } ?? []
            inner = ".tuple([\(componentTypes.joined(separator: ", "))])"
        }

    } else {
        inner = ".\(baseParameter.type)"
    }

    if isArray(parameter) {
        return ".array(\(inner))"
    } else {
        return inner
    }
}

func parameterToMatchableFieldType(p: Contract.ABI.Function.Parameter, index: Int, asField: Bool = false) -> String {
    // Note: it's comical that all of these cases need to be handled differently...
    let varName = parameterVar(parameter: p, index: index, withPrefix: "var")

    if isArray(p) {
        let baseParameter = baseParameter(p)
        if isTuple(p) {
            if let structName = structName(p) {
                if asField {
                    return ".array(\(structName).schema, \(varName).map { $0.asField })"
                } else {
                    return ".array(\(structName).schema, \(varName))"
                }
            } else {
                return "tuplearray"
            }
        } else {
            if asField {
                return ".array(.\(baseParameter.type), \(varName).map { .\(baseParameter.type)($0) })"
            } else {
                return ".array(.\(baseParameter.type), \(varName))"
            }
        }
    } else {
        if isTuple(p) {
            if false, let structName = structName(p) {
                return "\(varName)"
            } else {
                let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableFieldType(p: p, index: index * 10 + i, asField: asField) }
                return ".tuple\(componentTypes.count)(\(componentTypes.joined(separator: ", ")))"
            }
        } else {
            // turning them into the enum values, with name values
            return ".\(p.type)(\(varName))"
        }
    }
}

func parameterVar(parameter: Contract.ABI.Function.Parameter, index: Int, withPrefix prefix: String) -> String {
    return if parameter.name.isEmpty {
        "\(prefix)\(index)"
    } else {
        parameter.name
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

    return structsSoFar.keys.sorted().compactMap { structsSoFar[$0] }
}

func baseParameter(_ p: Contract.ABI.Function.Parameter) -> Contract.ABI.Function.Parameter {
    let newType = p.type.replacingOccurrences(of: "[]", with: "")
    let newInternalType = p.internalType.replacingOccurrences(of: "[]", with: "")
    return Contract.ABI.Function.Parameter(name: p.name, type: newType, internalType: newInternalType, components: p.components)
}

func makeStruccs(_ p: Contract.ABI.Function.Parameter, struccs: inout [String: StructDeclSyntax]) -> [String: StructDeclSyntax] {
    if let structName = structName(p) {
        let def = try! StructDeclSyntax(leadingTrivia: .newline, name: .identifier(structName, leadingTrivia: .space)) {
            // if we find a struct nestled down in an array somewhere, pretend it is a top level thing
            let baseParameter = baseParameter(p)
            try VariableDeclSyntax("static let schema: ABI.Schema = \(raw: "ABI.Schema" + parameterToFieldType(baseParameter))").with(\.trailingTrivia, .newlines(2))

            for c in p.components! {
                try VariableDeclSyntax("let \(raw: c.name): \(raw: typeMapper(for: c.internalType))")
            }

            try VariableDeclSyntax("var encoded: Data { asField.encoded }").with(\.trailingTrivia, .newlines(2)).with(\.leadingTrivia, .newlines(2))
            try VariableDeclSyntax("var asField: ABI.Field { \(raw: parameterToMatchableFieldType(p: baseParameter, index: 0, asField: true)) }").with(\.trailingTrivia, .newlines(1))

            try! FunctionDeclSyntax("""
            static func decode(data: Data) throws -> \(raw: typeMapper(for: baseParameter.internalType))
            """) {
                StmtSyntax("""

                            try decodeField(schema.decode(data))
                """)

            }.with(\.trailingTrivia, .newlines(1))
                .with(\.leadingTrivia, .newlines(1))

            try! FunctionDeclSyntax("""
            static func decodeField(_ field: ABI.Field) throws -> \(raw: typeMapper(for: baseParameter.internalType))
            """) {
                StmtSyntax("""

                switch field {
                case let \(raw: parameterToMatchableFieldType(p: baseParameter, index: 0)):
                    return \(raw: namedParameterToOutValue(p: baseParameter, index: 0))
                default:
                    throw ABI.DecodeError.mismatchedType(field.fieldType, schema)
                }
                """)

            }.with(\.trailingTrivia, .newlines(1))
                .with(\.leadingTrivia, .newlines(1))
        }
        struccs[p.internalType] = def
    }
    if let c = p.components {
        for cp in c {
            _ = makeStruccs(cp, struccs: &struccs)
        }
    }
    return struccs
}

func structName(_ p: Contract.ABI.Function.Parameter) -> String? {
    if p.internalType.starts(with: "struct") {
        baseParameter(p).internalType.replacingOccurrences(of: "struct ", with: "")
    } else {
        nil
    }
}

func isTuple(_ p: Contract.ABI.Function.Parameter) -> Bool {
    baseParameter(p).type == "tuple"
}

func isArray(_ p: Contract.ABI.Function.Parameter) -> Bool {
    p.type.contains("[]")
}

func asFieldMapper(parameter: Contract.ABI.Function.Parameter) throws -> String {
    if let structName = structName(parameter) {
        return "try \(structName).decodeField($0)"
    } else {
        switch parameter.type {
        case "bool":
            return "$0.asBool!"
        case "string":
            return "$0.asString!"
        case "address", "address payable":
            return "$0.asAddress!"
        case let type where type.starts(with: "uint"):
            return "$0.asBigUInt!"
        case let type where type.starts(with: "int"):
            return "$0.asBigInt!"
        case let bytesType where bytesType.starts(with: "bytes"):
            return "$0.asData!" // Dynamically-sized bytes sequence.
        default:
            throw NSError(domain: "TypeMapperError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unsupported type: \(parameter.type)"])
        }
    }
}
