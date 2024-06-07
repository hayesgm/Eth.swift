
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

// Create the struct declaration syntax
func createSourceFileSyntax(from contract: Contract, name: String) -> SourceFileSyntax {
    let structDecl = try! StructDeclSyntax(leadingTrivia: .newline, name: .identifier(name, leadingTrivia: .space)) {
        // Static variable for bytecode
        try VariableDeclSyntax("static let byteCode: String = \"\(raw: contract.bytecode.object)\"")
            .with(\.leadingTrivia, Trivia(pieces: [TriviaPiece.newlines(1), .spaces(4)]))
            .with(\.trailingTrivia, .newline)

        // Static variable for deployed bytecode
        try VariableDeclSyntax("static let deployedByteCode: String = \"\(raw: contract.bytecode.object)\"")
            .with(\.leadingTrivia, Trivia(pieces: [TriviaPiece.newlines(1), .spaces(4)]))
            .with(\.trailingTrivia, .newline)

        // Generate functions for each ABI function
        for function in contract.abi {
            let parameters = functionParameters(f: function)
            let outputs = returnValue(f: function)
            try FunctionDeclSyntax("""
            func \(raw: function.name)(\(raw: parameters.joined(separator: ", "))) -> \(raw: outputs)
            """) {
                StmtSyntax("""
                
                        let query = ABI.encode()
                        let out = try EVM.runQuery(bytecode: bytecode, query: query)

                        return ABI.decode(out)
                """)
                .with(\.leadingTrivia, Trivia(pieces: [.spaces(8)]))
                    .with(\.trailingTrivia, Trivia(pieces: [TriviaPiece.newlines(1), .spaces(4)]))
                
            }
            .with(\.leadingTrivia, Trivia(pieces: [TriviaPiece.newlines(1), .spaces(4)]))
            .with(\.trailingTrivia, .newline)
            //                        FunctionDeclSyntax(identifier: .identifier(function.name, leadingTrivia: .space), body: CodeBlockSyntax({
            //                            // Adding parameters
            //                            for input in function.inputs {
            //                                FunctionParameterSyntax(firstName: input.name, type: input.type == "uint256" ? "BigUInt" : "BigInt")
            //                            }
            //                            // Return type
            //                            ReturnClause(type: function.outputs.first?.type == "uint256" ? "BigUInt" : "BigInt")
            //                        })
            //                    })
        }
    }

    // Create the source file syntax
    let sourceFile = SourceFileSyntax {
        try! ImportDeclSyntax("import BigInt").with(\.trailingTrivia, .newline)
        try! ImportDeclSyntax("import EVM").with(\.trailingTrivia, .newline)
        structDecl
    }

    return sourceFile
}

func functionParameters(f: Contract.ABI.Function) -> [String] {
    var inputs: [String] = []
    
    for i in f.inputs {
        inputs.append("\(i.name): \(try! typeMapper(for: i.type))")
    }
    return inputs
}

func returnValue(f: Contract.ABI.Function) -> String {
    var outputs: [String] = []
    
    for i in f.outputs {
        outputs.append(try! typeMapper(for: i.type))
    }
    return outputs.joined(separator: ", ")
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
    let sourceCode = structNode.description

    var text = ""
    sourceCode.write(to: &text)
    return text
}
