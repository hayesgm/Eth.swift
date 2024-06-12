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
}
