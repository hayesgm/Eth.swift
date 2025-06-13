@testable import Eth
import SwiftNumber
import XCTest

final class EthWordTests: XCTestCase {
    func testInitEthWord() throws {
        XCTAssertEqual(
            EthWord(fromHexString: "0x112233445566778899aa112233445566778899aa112233445566778899aa1122")!.data,
            Data([0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22])
        )
        XCTAssertEqual(
            EthWord("0x112233445566778899aa112233445566778899aa112233445566778899aa1122").data,
            Data([0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22])
        )
        XCTAssertNil(EthWord(fromHexString: "0xaa"))
    }

    func testInitFromNumber() throws {
        XCTAssertEqual(EthWord(fromNumber: Number(0))!, "0x0000000000000000000000000000000000000000000000000000000000000000")
        XCTAssertEqual(EthWord(fromNumber: Number(1))!, "0x0000000000000000000000000000000000000000000000000000000000000001")
        XCTAssertEqual(EthWord(fromNumber: Number(2))!, "0x0000000000000000000000000000000000000000000000000000000000000002")
        XCTAssertEqual(EthWord(fromNumber: Number(256))!, "0x0000000000000000000000000000000000000000000000000000000000000100")
        XCTAssertEqual(EthWord(fromNumber: Number(257))!, "0x0000000000000000000000000000000000000000000000000000000000000101")
        XCTAssertEqual(EthWord(fromNumber: (Number(1) << 256) - 1)!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
    }

    func testInitFromSNumber() throws {
        XCTAssertEqual(EthWord(fromSNumber: SNumber(0))!, "0x0000000000000000000000000000000000000000000000000000000000000000")
        XCTAssertEqual(EthWord(fromSNumber: SNumber(-1))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
        XCTAssertEqual(EthWord(fromSNumber: SNumber(-2))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE")
        XCTAssertEqual(EthWord(fromSNumber: SNumber(-256))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00")
        XCTAssertEqual(EthWord(fromSNumber: SNumber(-257))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF")
        XCTAssertEqual(EthWord(fromSNumber: SNumber(2).power(254))!, "0x4000000000000000000000000000000000000000000000000000000000000000")
        // Largest valid signed value
        XCTAssertEqual(EthWord(fromSNumber: (SNumber(1) << 255) - 1)!, "0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        // Signed value overflow
        XCTAssertNil(EthWord(fromSNumber: (SNumber(1) << 255) + 1))
    }

    func testToSNumber() throws {
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")!.toSNumber(), SNumber(-1))
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE")!.toSNumber(), SNumber(-2))
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00")!.toSNumber(), SNumber(-256))
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF")!.toSNumber(), SNumber(-257))
        XCTAssertEqual(EthWord(fromHexString: "0x4000000000000000000000000000000000000000000000000000000000000000")!.toSNumber(), SNumber(2).power(254))
    }

    func testIsomorphicSNumbers() throws {
        for x in [-5, -20, -3000, -7542, -90000] {
            XCTAssertEqual(EthWord(fromData: EthWord(fromSNumber: SNumber(x))!.data)!.toSNumber(), SNumber(x), "\(x)")
        }
    }
}
