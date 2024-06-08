
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
    try! VariableDeclSyntax("""
    static let \(raw: f.name)Fn = ABI.Function(
            name: "\(raw: f.name)",
            inputs: [\(raw: mapToETHABITypes(f.inputs))],
            outputs: [\(raw: mapToETHABITypes(f.outputs))]
    )
    """)
    .with(\.trailingTrivia, .newline)
}

func mapToETHABITypes(_ ps: [Contract.ABI.Function.Parameter]) -> DeclSyntax {
    var out: [String] = []

    for p in ps {
        out.append(stringABITypeToStringyETHABIType(solidityType: p.type))
    }

    return DeclSyntax("\(raw: out.joined(separator: ", "))")
}

func stringABITypeToStringyETHABIType(solidityType: String) -> String {
    switch solidityType {
    case let tupleType where tupleType.contains("[]"):
        let tuple = tupleType.replacingOccurrences(of: "[]", with: "").components(separatedBy: ", ")
        var tupleFriend: [String] = []
        for tupleMember in tuple {
            tupleFriend.append(stringABITypeToStringyETHABIType(solidityType: tupleMember))
        }
        return ".tuple(\(tupleFriend.joined(separator: ", ")))"
    default:
        // low key turning them into the enum values
        return ".\(solidityType)"
    }
}

func generateFunctionDeclaration(f: Contract.ABI.Function) -> FunctionDeclSyntax {
    let parameters = functionParameters(f: f)
    let outputs = returnValue(f: f)

    return try! FunctionDeclSyntax("""
    static func \(raw: f.name)(\(raw: parameters.joined(separator: ", "))) throws -> \(raw: outputs)
    """) {
        StmtSyntax("""

                let query = try \(raw: f.name)Fn.encoded(with: [\(raw: callParameters(f: f))])
                let result = try EVM.runQuery(bytecode: bytecode, query: query)
                let decoded = try \(raw: f.name)Fn.decode(output: result)

                let oot : \(raw: outputs)
                switch (\(raw: matchableDecoded(f: f))) {
                case let (\(raw: outParameters(f: f))):
                    oot = \(raw: f.outputs.enumerated().map { index, _ in "out\(index)" }.joined(separator: ", "))
                default:
                    throw ABI.FunctionError.unexpectedError("invalid decode")
                }

                return oot
        """)
    }
    .with(\.leadingTrivia, .newline)
    .with(\.trailingTrivia, .newline)
}

func matchableDecoded(f: Contract.ABI.Function) -> String {
    return f.outputs.enumerated().map { index, o in
        "decoded[\(index)]"
    }.joined(separator: ", ")
}

func outParameters(f: Contract.ABI.Function) -> String {
    return f.outputs.enumerated().map { index, o in
        let n: String
        if o.name == "" {
            n = "out\(index)"
        } else {
            n = o.name
        }

        return "\(stringABITypeToStringyETHABIType(solidityType: o.type))(\(n))"
    }.joined(separator: ", ")
}

func callParameters(f: Contract.ABI.Function) -> String {
    return f.inputs.map { "\(stringABITypeToStringyETHABIType(solidityType: $0.type))(\($0.name))" }.joined(separator: ", ")
}

func functionParameters(f: Contract.ABI.Function) -> [String] {
    return f.inputs.map { "\($0.name): \(try! typeMapper(for: $0.type))" }
}

func returnValue(f: Contract.ABI.Function) -> String {
    f.outputs.map { try! typeMapper(for: $0.type) }.joined(separator: ", ")
}

func typeMapper(for t: String) throws -> String {
    switch t {
    case "bool":
        return "Bool"
    case "string":
        return "String"
    case "address", "address payable":
        return "String"
    case let type where type.starts(with: "uint"):
        return "BigUInt"
    case let type where type.starts(with: "int"):
        return "BigInt"
    case let bytesType where bytesType.starts(with: "bytes"):
        return "Data" // Dynamically-sized bytes sequence.
    case let arrayType where arrayType.contains("[]"):
        // this is wrong, need to try harder chatgpt :|
        let elementType = arrayType.replacingOccurrences(of: "[]", with: "")
        return "[\(try! typeMapper(for: elementType))]" // Recursive call to handle arrays of any type.
    default:
        throw SolidityTypeError.unknownType("Unknown Abi Type \(t)")
    }
}

enum SolidityTypeError: Error {
    case unknownType(String)
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
