import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

extension String {
    func withFirstLetterUppercased() -> String {
        guard let first = first else { return self }
        return first.uppercased() + dropFirst()
    }
}

func writeStringToFile(_ content: String, to filePath: String) -> Bool {
    let url = URL(fileURLWithPath: filePath)

    do {
        try content.write(to: url, atomically: true, encoding: .utf8)
        return true
    } catch {
        print("Failed to write to file: \(error)")
        return false
    }
}

func generateSwift() -> String {
    let properties = [
        "firstName": "String",
        "lastName": "String",
        "age": "Int",
    ]

    let source = SourceFileSyntax {
        StructDeclSyntax(name: "Person") {
            for (propertyName, propertyType) in properties {
                DeclSyntax("var \(raw: propertyName): \(raw: propertyType)")

                DeclSyntax(
                    """
                    func with\(raw: propertyName.withFirstLetterUppercased())(_ \(raw: propertyName): \(raw: propertyType)) -> Person {
                      var result = self
                      result.\(raw: propertyName) = \(raw: propertyName)
                      return result
                    }
                    """
                )
            }
        }
    }

    return source.formatted().description
}

func generateSwiftFile(input _: URL, outputDir: URL, prefix _: String? = nil) {
    let filePath = outputDir.appendingPathComponent("Cool.swift")
    _ = writeStringToFile(generateSwift(), to: filePath.path)
}
