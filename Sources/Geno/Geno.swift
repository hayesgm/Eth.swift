
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

var contractName: String = ""
// Create the struct declaration syntax
func createSourceFileSyntax(from contract: Contract, name: String, structsOnly: Bool) -> SourceFileSyntax {
    contractName = name // for ensuring structs aren't namespaced under the same name as the contract

    return SourceFileSyntax {
        try! ImportDeclSyntax("import BigInt").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import Eth").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import Foundation").with(\.trailingTrivia, .newline)

        try! EnumDeclSyntax(leadingTrivia: .newline, modifiers: [DeclModifierSyntax(name: .keyword(.public))], name: .identifier(name, leadingTrivia: .space)) {
            for s in generateStructs(c: contract) {
                s
            }

            if !structsOnly {
                try VariableDeclSyntax("public static let creationCode: Hex = \"\(raw: contract.bytecode.object)\"").with(\.trailingTrivia, .newline)
                try VariableDeclSyntax("public static let runtimeCode: Hex = \"\(raw: contract.deployedBytecode.object)\"").with(\.trailingTrivia, .newlines(2))

                // Generate ETH.ABI.Function to represent custom revert errors
                for error in contract.errors {
                    try! VariableDeclSyntax("""
                    public static let \(raw: errorName(error)) = ABI.Function(
                            name: "\(raw: error.name)",
                            inputs: [\(raw: mapToETHABITypes(error.inputs))]
                    )
                    """)
                    .with(\.trailingTrivia, .newlines(2))
                }

                // -- Begin Enums for revert errors
                let extendingErrorClause = InheritanceClauseSyntax(inheritedTypes: InheritedTypeListSyntax([
                    InheritedTypeSyntax(leadingTrivia: .space, type: TypeSyntax("Equatable,")),
                    InheritedTypeSyntax(leadingTrivia: .space, type: TypeSyntax("Error")),
                ]))
                EnumDeclSyntax(leadingTrivia: .newline, modifiers: [DeclModifierSyntax(name: .keyword(.public))], name: .identifier("RevertReason", leadingTrivia: .space, trailingTrivia: .space), inheritanceClause: extendingErrorClause) {
                    for e in contract.errors {
                        try! EnumCaseDeclSyntax("case \(raw: errorEnumCaseName(e))").with(\.leadingTrivia, .newline)
                    }
                    try! EnumCaseDeclSyntax("case unknownRevert(String, String)").with(\.leadingTrivia, .newline)
                }

                try FunctionDeclSyntax("""
                public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason
                """) {
                    SwitchExprSyntax(subject: ExprSyntax("(error, value)")) {
                        for error in contract.errors {
                            generateErrorSwitchCase(error)
                        }

                        SwitchCaseSyntax("""
                        case let (e, v):
                            return .unknownRevert(e.name, String(describing: v))
                        """).with(\.trailingTrivia, .newline)
                    }
                }.with(\.trailingTrivia, .newline)

                try VariableDeclSyntax("public static let errors: [ABI.Function] = [\(raw: contract.errors.map { errorName($0) }.joined(separator: ", "))]")
                // -- End Enums for revert errors

                // Generate a swift function and {ETH.ABI.Function} for each ABI function
                for function in contract.functions {
                    generateETHABIFunction(f: function)
                    generateFunctionDeclaration(f: function)
                }
            }
        }
    }
}

/// Generates the matching case statement for mapping the ErrorFn to the error enum to return the error enum
/// swift> generateErrorSwitchCase(Geno.Contract.ABI.Error(type: "error", name: "JustOneArg", inputs: [Geno.Contract.ABI.Function.Parameter(name: "", type: "bool", internalType: "bool", components: nil)]))
///          SwitchCaseSyntax("""
///          case (JustOneArgError, let .bool(value) ):
///             return .justOneArgError(value)
///          """)
func generateErrorSwitchCase(_ e: Contract.ABI.Error) -> SwitchCaseSyntax {
    let outBindings = if e.inputs.count == 0 {
        "_"
    } else {
        "let \(outParameters(ps: e.inputs))"
    }
    return SwitchCaseSyntax("""
    case (\(raw: errorName(e)), \(raw: outBindings)):
        return .\(raw: errorEnumWithBoundOutputs(e, namedOutputs: outValues(ps: e.inputs)))
    """).with(\.trailingTrivia, .newline)
}

/// Simply appends "Error" to the name given by the solc abi creator
///  swift> errorName(Geno.Contract.ABI.Error(type: "error", name: "JustOneArg", inputs: [Geno.Contract.ABI.Function.Parameter(name: "", type: "bool", internalType: "bool", components: nil)]))
///  > JustOneArgError
func errorName(_ e: Contract.ABI.Error) -> String {
    e.name + "Error"
}

/// Turns an error into the enum case name for the enum definition.
/// swift> enumCaseName(Geno.Contract.ABI.Error(type: "error", name: "JustOneArg", inputs: [Geno.Contract.ABI.Function.Parameter(name: "", type: "bool", internalType: "bool", components: nil)]))
/// "justOneArg(Bool)"
func errorEnumCaseName(_ e: Contract.ABI.Error) -> String {
    var out = e.name.prefix(1).lowercased() + e.name.dropFirst()
    if e.inputs.count > 0 {
        let inputs = e.inputs.map { p in typeMapper(for: p) }.joined(separator: ", ")
        out.append("(" + inputs + ")")
    }
    return out
}

/// Turns an error into the enum case which has bound over an attached variable
/// swift> enumCaseName(Geno.Contract.ABI.Error(type: "error", name: "JustOneArg", inputs: [Geno.Contract.ABI.Function.Parameter(name: "", type: "bool", internalType: "bool", components: nil)]), namedOutputs: "var0")
/// "justOneArg(var0)"
func errorEnumWithBoundOutputs(_ e: Contract.ABI.Error, namedOutputs: String?) -> String {
    var out = e.name.prefix(1).lowercased() + e.name.dropFirst()
    if e.inputs.count > 0, let outputNames = namedOutputs {
        // for when we are cases instances with bound values e.g. .justOneArg(someBoundBoolean) or .noArgs
        out.append("(" + outputNames + ")")
    }
    return out
}

/// eg. ["string", "address[]"] -> [.string, .array(.address)]
func mapToETHABITypes(_ ps: [Contract.ABI.Function.Parameter]) -> DeclSyntax {
    let out: String = ps.map { parameterToValueType($0) }.joined(separator: ", ")

    return DeclSyntax("\(raw: out)")
}

func generateETHABIFunction(f: Contract.ABI.Function) -> VariableDeclSyntax {
    return try! VariableDeclSyntax("""
    public static let \(raw: f.name)Fn = ABI.Function(
            name: "\(raw: f.name)",
            inputs: [\(raw: mapToETHABITypes(f.inputs))],
            outputs: [\(raw: mapToETHABITypes(f.outputs))]
    )
    """)
    .with(\.trailingTrivia, .newline)
}

func generateFunctionDeclaration(f: Contract.ABI.Function) -> FunctionDeclSyntax {
    var parameters = functionParameters(f: f)
    let outputs = returnValue(f: f)

    parameters.append("withFunctions ffis: EVM.FFIMap = [:]")

    return try! FunctionDeclSyntax("""
    public static func \(raw: f.name)(\(raw: parameters.joined(separator: ", "))) async throws -> Result<\(raw: outputs), RevertReason>
    """) {
        StmtSyntax("""
                do {
                    let query = try \(raw: f.name)Fn.encoded(with: [\(raw: callParameters(f: f))])
                    let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
                    let decoded = try \(raw: f.name)Fn.decode(output: result)

                    switch decoded {
                    case let \(raw: outParameters(ps: f.outputs)):
                        return .success(\(raw: outValues(ps: f.outputs)))
                    default:
                        throw ABI.DecodeError.mismatchedType(decoded.schema, \(raw: f.name)Fn.outputTuple)
                    }
                } catch let EVM.QueryError.error(e, v) {
                    return .failure(rewrapError(e, value: v))
                }
        """)
    }
    .with(\.leadingTrivia, .newline)
    .with(\.trailingTrivia, .newlines(2))
}

func outValues(ps: [Contract.ABI.Function.Parameter]) -> String {
    ps.enumerated().map { index, p in
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
        let bp = baseParameter(parameter)
        return "\(parameter.name).map { \(try! asValueMapper(parameter: bp)) }"
    } else if structName(parameter) != nil {
        return try! asValueMapper(parameter: parameter, name: parameter.name)
    } else {
        return parameter.name
    }
}

/// swiftt> structInitializer(parameter: Geno.Contract.ABI.Function.Parameter(name: "c", type: "tuple", internalType: "struct Cat", components: Optional([Geno.Contract.ABI.Function.Parameter(name: "ca", type: "int256", internalType: "int256", components: nil), Geno.Contract.ABI.Function.Parameter(name: "cb", type: "bytes", internalType: "bytes", components: nil), Geno.Contract.ABI.Function.Parameter(name: "cc", type: "bytes32", internalType: "bytes32", components: nil)]), structName: "Cat)
/// > "Cat(ca: ca, cb: cb, cc: cc)"
func structInitializer(parameter p: Contract.ABI.Function.Parameter, structName: String) -> String {
    if let c = p.components {
        let args = c.enumerated().map { "\($0.1.name): \(fieldValue(parameter: $0.1, index: $0.0))" }.joined(separator: ", ")

        if args.range(of: "try") != nil {
            // Struct initialization with nested fields may contain decodes that throw, so we need the `try` keyword in many but not all cases
            // This conditional makes the generator less prone to generating warnings for unused `try`
            return "try \(structName)(\(args))"
        } else {
            return "\(structName)(\(args))"
        }

    } else {
        return p.name
    }
}

func outParameters(ps: [Contract.ABI.Function.Parameter]) -> String {
    let inner = ps.enumerated().map { index, o in
        parameterToMatchableValueType(p: o, index: index)
    }.joined(separator: ", ")

    guard ps.count <= 16 else {
        // Note the count constraint could be expanded by adding more tuple{n} cases to the ABI.Value enum. 16 is chosen as a reasonable max until expansion is needed.
        fatalError("Geno cannot decode tuples with more than 16 values")
    }
    return ".tuple\(ps.count)(\(inner))"
}

func callParameters(f: Contract.ABI.Function) -> String {
    return f.inputs.map { p in
        if isArray(p) {
            if isStruct(p) {
                let structName = structName(p)!
                return ".array(\(structName).schema, \(p.name).map { $0.asValue })"
            } else {
                let baseParameter = baseParameter(p)
                return ".array(.\(baseParameter.type), \(p.name).map { .\(baseParameter.type)($0) })"
            }
        } else if isStruct(p) {
            return "\(p.name).asValue"
        } else if isTuple(p) {
            let componentTypes = p.components!.enumerated().map { _, p in parameterToValueType(p, allowSchema: true) }
            return ".tuple\(componentTypes.count)(\(componentTypes.joined(separator: ",\n ")))"
        } else {
            // turning them into the enum values, with name values
            return ".\(p.type)(\(p.name))"
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

func generateAbiFile(input_path: URL, structsOnly: Bool) -> String {
    let data = try! Data(contentsOf: input_path)
    let contract = try! JSONDecoder().decode(Contract.self, from: data)

    // Create the struct syntax node
    let structNode = createSourceFileSyntax(from: contract, name: String(input_path.lastPathComponent.split(separator: ".").first!), structsOnly: structsOnly)

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

    // Dictionary to hold grouped structs by namespace
    var groupedStructs: [String: [StructDeclSyntax]] = [:]
    var ungroupedStructs: [StructDeclSyntax] = []

    for (structName, structDecl) in structsSoFar {
        let namespaceParts = structName.split(separator: ".")

        if namespaceParts.count > 1 {
            let namespace = String(namespaceParts.first!)
            if groupedStructs[namespace] == nil {
                groupedStructs[namespace] = []
            }
            groupedStructs[namespace]!.append(structDecl)
        } else {
            ungroupedStructs.append(structDecl)
        }
    }

    // Sort the ungrouped structs alphabetically by their name
    ungroupedStructs.sort { $0.name.text < $1.name.text }

    // Sort the grouped structs and their namespaces
    let sortedNamespaces = groupedStructs.keys.sorted()
    var finalStructs: [StructDeclSyntax] = ungroupedStructs

    for namespace in sortedNamespaces {
        let structs = groupedStructs[namespace]!.sorted { $0.name.text < $1.name.text }
        let wrappedStruct = StructDeclSyntax(
            leadingTrivia: .newline,
            modifiers: [DeclModifierSyntax(name: .keyword(.public))],
            name: .identifier(namespace, leadingTrivia: .space)
        ) {
            for structDecl in structs {
                structDecl
            }
        }
        finalStructs.append(wrappedStruct)
    }

    return finalStructs
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
        let def = try! StructDeclSyntax(leadingTrivia: .newline, modifiers: [DeclModifierSyntax(name: .keyword(.public))], name: .identifier(String(nameParts.last!), leadingTrivia: .space), inheritanceClause: equatableClause) {
            // if we find a struct nestled down in an array somewhere, pretend it is a top level thing
            let baseParameter = baseParameter(p)
            try VariableDeclSyntax("public static let schema: ABI.Schema = \(raw: "ABI.Schema" + parameterToValueType(baseParameter))").with(\.trailingTrivia, .newlines(2))

            for c in p.components! {
                try VariableDeclSyntax("public let \(raw: c.name): \(raw: typeMapper(for: c))")
            }

            let initArgs = p.components!.map { "\($0.name): \(typeMapper(for: $0))" }.joined(separator: ", ")
            let initBody = p.components!.map { "self.\($0.name) = \($0.name)" }.joined(separator: "\n ")
            DeclSyntax("""
            public init(\(raw: initArgs)) {
              \(raw: initBody)
            }
            """).with(\.leadingTrivia, .newlines(2))
            try VariableDeclSyntax("public var encoded: Hex { asValue.encoded }").with(\.trailingTrivia, .newlines(2)).with(\.leadingTrivia, .newlines(2))
            try VariableDeclSyntax("public var asValue: ABI.Value { \(raw: parameterToMatchableValueType(p: baseParameter, index: 0, asValue: true)) }").with(\.trailingTrivia, .newlines(1))

            try! FunctionDeclSyntax("""
            public static func decode(hex: Hex) throws -> \(raw: typeMapper(for: baseParameter))
            """) {
                ExprSyntax("""

                  if let value = try? schema.decode(hex) { return try decodeValue(value) }
                  // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
                  if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
                      return try decodeValue(wrappedValue)
                  }
                  // retry original to throw the error
                  return try decodeValue(schema.decode(hex))
                """).with(\.trailingTrivia, .newlines(2))
                    .with(\.leadingTrivia, .newlines(1))

            }.with(\.trailingTrivia, .newlines(1))
                .with(\.leadingTrivia, .newlines(1))

            try! FunctionDeclSyntax("""
            public static func decodeValue(_ value: ABI.Value) throws -> \(raw: typeMapper(for: baseParameter))
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

        struccs[structName] = def
    }
    if let c = p.components {
        for cp in c {
            makeStruccs(cp, struccs: &struccs)
        }
    }
}

func structName(_ p: Contract.ABI.Function.Parameter) -> String? {
    if p.internalType.starts(with: "struct") {
        baseParameter(p).internalType
            .replacingOccurrences(of: "struct \(contractName).", with: "")
            .replacingOccurrences(of: "struct ", with: "")
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
    structName(p) != nil
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
            return "$0.asEthAddress!"
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
