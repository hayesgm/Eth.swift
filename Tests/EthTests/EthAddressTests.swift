@testable import Eth
import XCTest

final class EthAddressTests: XCTestCase {
    func testInitEthAddress() throws {
        XCTAssertEqual(
            EthAddress(fromHexString: "0x112233445566778899aa112233445566778899aa")!.address.data,
            Data([0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA])
        )
        XCTAssertNil(EthAddress(fromHexString: "0xaa"))
    }

    func testAddressEncodingDecoding() {
        let address = EthAddress("0xdef1c0ded9bec7f1a1670819833240f027b25eff")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(address)

            let decoder = JSONDecoder()
            let decodedHex = try decoder.decode(EthAddress.self, from: data)

            XCTAssertEqual(address, decodedHex, "Encoded and decoded values should be equal")
        } catch {
            XCTFail("Encoding or decoding failed: \(error)")
        }
    }

    func testAddressDecodeInvalidLength() {
        let hex = Hex("0xdef1c0ded9bec7f1a1670819833240f027b25eff22334455")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(hex)

            let decoder = JSONDecoder()
            _ = try decoder.decode(EthAddress.self, from: data)

            XCTFail("Should have failed invalid address length")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }

    func testChecksumAddress() {
        let address = EthAddress("0xdef1c0ded9bec7f1a1670819833240f027b25eff")
        XCTAssertEqual(address.checksum, "0xDef1C0ded9bec7F1a1670819833240f027b25EfF", "Should be checksummed address")
    }
}
