@testable import Eth
import XCTest

final class HexTests: XCTestCase {
    func testParseHex() throws {
        XCTAssertEqual(Hex.parseHex("0x"), Data([]))
        XCTAssertEqual(Hex.parseHex("0x0"), Data([0x0]))
        XCTAssertEqual(Hex.parseHex("0x00"), Data([0x0]))
        XCTAssertEqual(Hex.parseHex("0x1122"), Data([0x11, 0x22]))
        XCTAssertEqual(Hex.parseHex("1122"), Data([0x11, 0x22]))
        XCTAssertNil(Hex.parseHex("gg"))
    }
}
