@testable import Eth
import XCTest

final class HexTests: XCTestCase {
    func testDataFromHexString() throws {
        XCTAssertEqual(Hex.dataFromHexString("0x"), Data([]))
        XCTAssertEqual(Hex.dataFromHexString("0x0"), Data([0x0]))
        XCTAssertEqual(Hex.dataFromHexString("0x00"), Data([0x0]))
        XCTAssertEqual(Hex.dataFromHexString("0x1122"), Data([0x11, 0x22]))
        XCTAssertEqual(Hex.dataFromHexString("1122"), Data([0x11, 0x22]))
        XCTAssertNil(Hex.dataFromHexString("gg"))
    }

    func testParseHexString() throws {
        XCTAssertEqual(try! Hex.parseHex("0x"), Data([]))
        XCTAssertEqual(try! Hex.parseHex("0x0"), Data([0x0]))
        XCTAssertEqual(try! Hex.parseHex("0x00"), Data([0x0]))
        XCTAssertEqual(try! Hex.parseHex("0x1122"), Data([0x11, 0x22]))
        XCTAssertEqual(try! Hex.parseHex("1122"), Data([0x11, 0x22]))
        do {
            _ = try Hex.parseHex("gg")
            XCTFail("gg: Expected error, none received")
        } catch let error as Hex.HexError {
            XCTAssertEqual(error, Hex.HexError.invalidHex("gg"))
        }
    }

    func testHexFromData() throws {
        XCTAssertEqual(Hex(Data([0x0])).data, Data([0x0]))
    }

    func testHexFromString() throws {
        XCTAssertEqual(Hex(hex: "0x"), Hex(Data([])))
        XCTAssertEqual(Hex(hex: "0x0"), Hex(Data([0x0])))
        XCTAssertEqual(Hex(hex: "0x00"), Hex(Data([0x0])))
        XCTAssertEqual(Hex(hex: "0x1122"), Hex(Data([0x11, 0x22])))
        XCTAssertEqual(Hex(hex: "1122"), Hex(Data([0x11, 0x22])))
        // TODO: Handle raise
        XCTAssertNil(Hex(hex: "gg"))
    }

    func testHexFromStringLiteral() throws {
        XCTAssertEqual(Hex("0x1122"), Hex(Data([0x11, 0x22])))
        // Uncomment to test compilation error:
        // Hex("gg")
    }

    func testHexDotDescription() {
        XCTAssertEqual(Hex("0x").description, "0x")
        XCTAssertEqual(Hex("0x0").description, "0x00")
        XCTAssertEqual(Hex("0x00").description, "0x00")
        XCTAssertEqual(Hex("0x1122").description, "0x1122")
    }

    func testHexDotHex() {
        XCTAssertEqual(Hex("0x").hex, "0x")
        XCTAssertEqual(Hex("0x0").hex, "0x00")
        XCTAssertEqual(Hex("0x00").hex, "0x00")
        XCTAssertEqual(Hex("0x1122").hex, "0x1122")
        XCTAssertEqual(Hex("1122").hex, "0x1122")
    }

    func testHexDotShortHex() {
        XCTAssertEqual(Hex("0x").shortHex, "0x0")
        XCTAssertEqual(Hex("0x0").shortHex, "0x0")
        XCTAssertEqual(Hex("0x00").shortHex, "0x0")
        XCTAssertEqual(Hex("0x1122").shortHex, "0x1122")
        XCTAssertEqual(Hex("0x0122").shortHex, "0x122")
        XCTAssertEqual(Hex("1122").shortHex, "0x1122")
    }

    func testHexEncodingDecoding() {
        let hex = Hex("0xdef1c0ded9bec7f1a1670819833240f027b25eff")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(hex)

            let decoder = JSONDecoder()
            let decodedHex = try decoder.decode(Hex.self, from: data)

            XCTAssertEqual(hex, decodedHex, "Encoded and decoded values should be equal")
        } catch {
            XCTFail("Encoding or decoding failed: \(error)")
        }
    }
}
