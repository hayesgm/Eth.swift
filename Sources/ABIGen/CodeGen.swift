import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

extension String {
    func withFirstLetterUppercased() -> String {
        guard let first = first else { return self }
        return first.uppercased() + dropFirst()
    }
}

func replaceFileExtension(of fileName: String, with newExtension: String) -> String {
    let fileURL = URL(fileURLWithPath: fileName)
    let fileNameWithoutExtension = fileURL.deletingPathExtension().lastPathComponent
    let newFileName = "\(fileNameWithoutExtension).\(newExtension)"
    return newFileName
}

func writeStringToFile(_ content: String, to filePath: String) throws {
    let url = URL(fileURLWithPath: filePath)
    try content.write(to: url, atomically: true, encoding: .utf8)
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

func generateSwiftFile(input: URL, outputDir: URL, prefix _: String? = nil) throws {
    let fileName = input.lastPathComponent
    let outFileName = replaceFileExtension(of: fileName, with: "swift")
    let filePath = outputDir.appendingPathComponent(outFileName)
    print("outFile: \(filePath)")
    try writeStringToFile(generateSwift(), to: filePath.path)
}
