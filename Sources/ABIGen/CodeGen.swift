import SwiftSyntax
import SwiftSyntaxBuilder

extension String {
    func withFirstLetterUppercased() -> String {
        guard let first = first else { return self }
        return first.uppercased() + dropFirst()
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
