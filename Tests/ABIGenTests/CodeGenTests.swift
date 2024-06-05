@testable import ABIGen
import XCTest

final class CodeGenTests: XCTestCase {
    func testGenerateSwift() throws {
        XCTAssertEqual(generateSwift(), "Hello")
    }
}
