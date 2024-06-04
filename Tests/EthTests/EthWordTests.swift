import BigInt
@testable import Eth
import XCTest

final class EthWordTests: XCTestCase {
    func testInitEthWord() throws {
        XCTAssertEqual(
            EthWord(hex: "0x112233445566778899aa112233445566778899aa112233445566778899aa1122")!.data,
            Data([0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22])
        )
        XCTAssertNil(EthWord(hex: "0xaa"))
    }

    func testInitFromBigInt() throws {
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-1))!, EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"))
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-2))!, EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE"))
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-256))!, EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00"))
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-257))!, EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF"))
    }

    func testToBigInt() throws {
        XCTAssertEqual(EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")!.toBigInt(), BigInt(-1))
        XCTAssertEqual(EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE")!.toBigInt(), BigInt(-2))
        XCTAssertEqual(EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00")!.toBigInt(), BigInt(-256))
        XCTAssertEqual(EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF")!.toBigInt(), BigInt(-257))
    }

    func testIsomorphicBigInts() throws {
        for x in [-5, -20, -3000, -7542, -90000] {
            XCTAssertEqual(EthWord(EthWord(fromBigInt: BigInt(x))!.data)!.toBigInt(), BigInt(x), "\(x)")
        }
    }
}
