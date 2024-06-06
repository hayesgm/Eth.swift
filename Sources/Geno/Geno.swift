import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

// Function to create a SourceFileSyntax from a struct using reflection
func createSourceFileSyntax<T>(from instance: T, name: String) ->
SourceFileSyntax {
    // Reflect on the instance to get its properties and values
    
    let mirror = Mirror(reflecting: instance)

    // Create the struct declaration syntax
    let structDecl = StructDeclSyntax(leadingTrivia: .newline, 
                                      name: .identifier(name, leadingTrivia: .space)) {
        // Iterate over the properties
        for child in mirror.children {
            if let propertyName = child.label {
                let propertyValue = child.value
                let typeName = String(describing: type(of: propertyValue))
                
                DeclSyntax("let \(raw: propertyName): \(raw: typeName) = \(raw: propertyValue)")
                    .with(\.leadingTrivia, Trivia(pieces: [TriviaPiece.newlines(1), .spaces(4)]))
                    .with(\.trailingTrivia, .newline)
            }
        }
    }.with(\.trailingTrivia, .newline)

    // Create the source file syntax
    let sourceFile = SourceFileSyntax {
        structDecl
    }

    return sourceFile
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
