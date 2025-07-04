@testable import Eth
import SwiftNumber
import XCTest

final class ExampleTests: XCTestCase {
    func testDrollAddition() async throws {
        let error = try await Drool.additionVmCall(x: Number(5))
        XCTAssertEqual(error, Number(60), "additionVmCall(5)")
    }

    func testCatEncode() throws {
        let cat = Cat(name: "Sprinkles", age: 10)
        // cast abi-encode 'cool(string,uint8)' 'Sprinkles' 10
        XCTAssertEqual(cat.encoded, "0x0000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000009537072696e6b6c65730000000000000000000000000000000000000000000000", "cat.encoded")
    }

    func testCatDecode() throws {
        let expCat = Cat(name: "Sprinkles", age: 10)
        // cast abi-encode 'cool(string,uint8)' 'Sprinkles' 10
        let encoded: Hex = "0x0000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000009537072696e6b6c65730000000000000000000000000000000000000000000000"
        XCTAssertEqual(try Cat.decode(hex: encoded), expCat, "cat.decoded")
    }
}
