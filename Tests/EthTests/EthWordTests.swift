import BigInt
@testable import Eth
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

    func testInitFromBigUInt() throws {
        XCTAssertEqual(EthWord(fromBigUInt: BigUInt(0))!, "0x0000000000000000000000000000000000000000000000000000000000000000")
        XCTAssertEqual(EthWord(fromBigUInt: BigUInt(1))!, "0x0000000000000000000000000000000000000000000000000000000000000001")
        XCTAssertEqual(EthWord(fromBigUInt: BigUInt(2))!, "0x0000000000000000000000000000000000000000000000000000000000000002")
        XCTAssertEqual(EthWord(fromBigUInt: BigUInt(256))!, "0x0000000000000000000000000000000000000000000000000000000000000100")
        XCTAssertEqual(EthWord(fromBigUInt: BigUInt(257))!, "0x0000000000000000000000000000000000000000000000000000000000000101")
        XCTAssertEqual(EthWord(fromBigUInt: (BigUInt(1) << 256) - 1)!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
    }

    func testInitFromBigInt() throws {
        XCTAssertEqual(EthWord(fromBigInt: BigInt(0))!, "0x0000000000000000000000000000000000000000000000000000000000000000")
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-1))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-2))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE")
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-256))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00")
        XCTAssertEqual(EthWord(fromBigInt: BigInt(-257))!, "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF")
        XCTAssertEqual(EthWord(fromBigInt: BigInt(2).power(254))!, "0x4000000000000000000000000000000000000000000000000000000000000000")
        // Largest valid signed value
        XCTAssertEqual(EthWord(fromBigInt: (BigInt(1) << 255) - 1)!, "0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        // Signed value overflow
        XCTAssertNil(EthWord(fromBigInt: (BigInt(1) << 255) + 1))
    }

    func testToBigInt() throws {
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")!.toBigInt(), BigInt(-1))
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE")!.toBigInt(), BigInt(-2))
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00")!.toBigInt(), BigInt(-256))
        XCTAssertEqual(EthWord(fromHexString: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF")!.toBigInt(), BigInt(-257))
        XCTAssertEqual(EthWord(fromHexString: "0x4000000000000000000000000000000000000000000000000000000000000000")!.toBigInt(), BigInt(2).power(254))
    }

    func testIsomorphicBigInts() throws {
        for x in [-5, -20, -3000, -7542, -90000] {
            XCTAssertEqual(EthWord(fromData: EthWord(fromBigInt: BigInt(x))!.data)!.toBigInt(), BigInt(x), "\(x)")
        }
    }
}
