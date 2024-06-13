
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

// Create the struct declaration syntax
func createSourceFileSyntax(from contract: Contract, name: String) -> SourceFileSyntax {
    return SourceFileSyntax {
        try! ImportDeclSyntax("import BigInt").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import Eth").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import Foundation").with(\.trailingTrivia, .newline)

        try! EnumDeclSyntax(leadingTrivia: .newline, name: .identifier(name, leadingTrivia: .space)) {
            for s in generateStructs(c: contract) {
                s
            }

            try VariableDeclSyntax("static let creationCode: Hex = \"\(raw: contract.bytecode.object)\"").with(\.trailingTrivia, .newline)
            try VariableDeclSyntax("static let runtimeCode: Hex = \"\(raw: contract.deployedBytecode.object)\"").with(\.trailingTrivia, .newlines(2))

            // Generate ETH.ABI.Function to represent custom revert errors
            for error in contract.errors {
                try! VariableDeclSyntax("""
                static let \(raw: errorName(error)) = ABI.Function(
                        name: "\(raw: error.name)",
                        inputs: [\(raw: mapToETHABITypes(error.inputs))]
                )
                """)
                .with(\.trailingTrivia, .newlines(2))
            }

            try VariableDeclSyntax("static let errors: [ABI.Function] = [\(raw: contract.errors.map { errorName($0) }.joined(separator: ", "))]")

            // Generate a swift function and {ETH.ABI.Function} for each ABI function
            for function in contract.functions {
                generateETHABIFunction(f: function)
                generateFunctionDeclaration(f: function)
            }
        }
    }
}

func errorName(_ e: Contract.ABI.Error) -> String {
    e.name + "Error"
}

func mapToETHABITypes(_ ps: [Contract.ABI.Function.Parameter]) -> DeclSyntax {
    let out: String = ps.map { parameterToValueType($0) }.joined(separator: ", ")

    return DeclSyntax("\(raw: out)")
}

func generateETHABIFunction(f: Contract.ABI.Function) -> VariableDeclSyntax {
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
                let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
                let decoded = try \(raw: f.name)Fn.decode(output: result)

                switch decoded {
                case let \(raw: outParameters(f: f)):
                    return \(raw: outValues(f: f))
                default:
                    throw ABI.DecodeError.mismatchedType(decoded.schema, \(raw: f.name)Fn.outputTuple)
                }
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
    if isArray(p) {
        if isTuple(p) {
            let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableValueType(p: p, index: i) }
            return ".array(.tuple([\(componentTypes.joined(separator: ", "))]))"
        } else {
            return ".array(\(baseParameter(p)))"
        }
    } else if isTuple(p) {
        if let structName = structName(p) {
            return structInitializer(parameter: p, structName: structName)
        } else {
            let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableValueType(p: p, index: i) }
            return "(\(componentTypes.joined(separator: ", ")))"
        }
    } else {
        return parameterVar(parameter: p, index: index, withPrefix: "var")
    }
}

func fieldValue(parameter: Contract.ABI.Function.Parameter, index _: Int) -> String {
    if isArray(parameter) {
        return "\(parameter.name).map { \(try! asValueMapper(parameter: parameter)) }"
    } else if structName(parameter) != nil {
        return try! asValueMapper(parameter: parameter, name: parameter.name)
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
        parameterToMatchableValueType(p: o, index: index)
    }.joined(separator: ", ")

    guard f.outputs.count <= 16 else {
        // Note the count constraint could be expanded by adding more tuple{n} cases to the ABI.Value enum. 16 is chosen as a reasonable max until expansion is needed.
        fatalError("Geno cannot decode tuples with more than 16 values")
    }
    return ".tuple\(f.outputs.count)(\(inner))"
}

func callParameters(f: Contract.ABI.Function) -> String {
    return f.inputs.map { parameter in
        if structName(parameter) != nil {
            "\(parameter.name).asValue"
        } else {
            "\(parameterToValueType(parameter, allowSchema: true))(\(parameter.name))"
        }
    }.joined(separator: ", ")
}

func functionParameters(f: Contract.ABI.Function) -> [String] {
    return f.inputs.map { "\($0.name): \(typeMapper(for: $0))" }
}

func returnValue(f: Contract.ABI.Function) -> String {
    f.outputs.map { typeMapper(for: $0) }.joined(separator: ", ")
}

func parameterToValueType(_ parameter: Contract.ABI.Function.Parameter, allowSchema: Bool = false) -> String {
    let inner: String
    let baseParameter = baseParameter(parameter)

    if isTuple(parameter) {
        if allowSchema, let structName = structName(parameter) {
            inner = "\(structName).schema"
        } else {
            let componentTypes = parameter.components?.map { parameterToValueType($0, allowSchema: true) } ?? []
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

func parameterToMatchableValueType(p: Contract.ABI.Function.Parameter, index: Int, asValue: Bool = false, isChild: Bool = false) -> String {
    // Note: it's comical that all of these cases need to be handled differently...
    let varName = parameterVar(parameter: p, index: index, withPrefix: "var")

    if isArray(p) {
        let baseParameter = baseParameter(p)
        if isTuple(p) {
            let structName = structName(p)!
            if asValue {
                return ".array(\(structName).schema, \(varName).map { $0.asValue })"
            } else {
                return ".array(\(structName).schema, \(varName))"
            }
        } else {
            if asValue {
                return ".array(.\(baseParameter.type), \(varName).map { .\(baseParameter.type)($0) })"
            } else {
                return ".array(.\(baseParameter.type), \(varName))"
            }
        }
    } else {
        if isTuple(p) {
            if isChild && structName(p) != nil {
                if asValue {
                    return "\(varName).asValue"
                } else {
                    return varName
                }
            } else {
                let componentTypes = p.components!.enumerated().map { i, p in parameterToMatchableValueType(p: p, index: index * 10 + i, asValue: asValue, isChild: true) }
                return ".tuple\(componentTypes.count)(\(componentTypes.joined(separator: ",\n ")))"
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

func typeMapper(for p: Contract.ABI.Function.Parameter) -> String {
    if isArray(p) {
        return "[\(typeMapper(for: baseParameter(p)))]"
    }

    if isStruct(p) {
        return structName(p)!
    }

    switch p.type {
    case "bool":
        return "Bool"
    case "string":
        return "String"
    case "address", "address payable":
        return "EthAddress"
    case "tuple":
        return "tuple"
    case "uint8":
        return "UInt"
    case "uint16":
        return "UInt"
    case "uint24":
        return "UInt"
    case "uint32":
        return "UInt"
    case let type where type.starts(with: "uint"):
        return "BigUInt"
    case "int8":
        return "Int"
    case "int16":
        return "Int"
    case "int24":
        return "Int"
    case "int32":
        return "Int"
    case let type where type.starts(with: "int"):
        return "BigInt"
    case let bytesType where bytesType.starts(with: "bytes"):
        return "Hex" // Dynamically-sized bytes sequence.
    default:
        fatalError("TypeMapperError :Unsupported type: \(p.type) internally, \(p)")
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
    for f in c.functions {
        for i in f.inputs {
            makeStruccs(i, struccs: &structsSoFar)
        }

        for o in f.outputs {
            makeStruccs(o, struccs: &structsSoFar)
        }
    }

    return structsSoFar.keys.sorted().compactMap { structsSoFar[$0] }
}

func baseParameter(_ p: Contract.ABI.Function.Parameter) -> Contract.ABI.Function.Parameter {
    let newType = p.type.replacingOccurrences(of: "[]", with: "")
    let newInternalType = p.internalType.replacingOccurrences(of: "[]", with: "")
    return Contract.ABI.Function.Parameter(name: p.name, type: newType, internalType: newInternalType, components: p.components)
}

func makeStruccs(_ p: Contract.ABI.Function.Parameter, struccs: inout [String: StructDeclSyntax]) {
    if let structName = structName(p) {
        let equatableClause = InheritanceClauseSyntax(inheritedTypes: InheritedTypeListSyntax([InheritedTypeSyntax(leadingTrivia: .space, type: TypeSyntax("Equatable"))]))

        let nameParts = structName.split(separator: ".")
        let def = try! StructDeclSyntax(leadingTrivia: .newline, name: .identifier(String(nameParts.last!), leadingTrivia: .space), inheritanceClause: equatableClause) {
            // if we find a struct nestled down in an array somewhere, pretend it is a top level thing
            let baseParameter = baseParameter(p)
            try VariableDeclSyntax("static let schema: ABI.Schema = \(raw: "ABI.Schema" + parameterToValueType(baseParameter))").with(\.trailingTrivia, .newlines(2))

            for c in p.components! {
                try VariableDeclSyntax("let \(raw: c.name): \(raw: typeMapper(for: c))")
            }

            try VariableDeclSyntax("var encoded: Hex { asValue.encoded }").with(\.trailingTrivia, .newlines(2)).with(\.leadingTrivia, .newlines(2))
            try VariableDeclSyntax("var asValue: ABI.Value { \(raw: parameterToMatchableValueType(p: baseParameter, index: 0, asValue: true)) }").with(\.trailingTrivia, .newlines(1))

            try! FunctionDeclSyntax("""
            static func decode(hex: Hex) throws -> \(raw: typeMapper(for: baseParameter))
            """) {
                ExprSyntax("""
                try decodeValue(schema.decode(hex))
                """).with(\.trailingTrivia, .newlines(2))
                    .with(\.leadingTrivia, .newlines(1))

            }.with(\.trailingTrivia, .newlines(1))
                .with(\.leadingTrivia, .newlines(1))

            try! FunctionDeclSyntax("""
            static func decodeValue(_ value: ABI.Value) throws -> \(raw: typeMapper(for: baseParameter))
            """) {
                StmtSyntax("""

                switch value {
                case let \(raw: parameterToMatchableValueType(p: baseParameter, index: 0)):
                    return \(raw: namedParameterToOutValue(p: baseParameter, index: 0))
                default:
                    throw ABI.DecodeError.mismatchedType(value.schema, schema)
                }
                """)

            }.with(\.trailingTrivia, .newlines(1))
                .with(\.leadingTrivia, .newlines(1))
        }

        if structName.contains(".") {
            // when importing contracts in solidity, the structs become namespaced
            let namespace = structName.split(separator: ".").first!
            struccs[structName] = StructDeclSyntax(leadingTrivia: .newline, name: .identifier(String(namespace), leadingTrivia: .space)) {
                def
            }
        } else {
            struccs[structName] = def
        }
    }
    if let c = p.components {
        for cp in c {
            makeStruccs(cp, struccs: &struccs)
        }
    }
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
    p.type.hasSuffix("[]")
}

func isStruct(_ p: Contract.ABI.Function.Parameter) -> Bool {
    structName(p) != nil && !isArray(p)
}

func asValueMapper(parameter: Contract.ABI.Function.Parameter, name: String = "$0") throws -> String {
    if let structName = structName(parameter) {
        return "try \(structName).decodeValue(\(name))"
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
            return "$0.asHex!" // Dynamically-sized bytes sequence.
        default:
            throw NSError(domain: "TypeMapperError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unsupported type: \(parameter.type)"])
        }
    }
}
