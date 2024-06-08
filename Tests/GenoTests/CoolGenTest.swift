import XCTest
import BigInt

final class CoolGenTests: XCTestCase {
    func testDecodeContract() {
        XCTAssertEqual(try Cool.sum(x: BigUInt(1000), y: BigUInt(1000)), BigUInt(12), "additionVmCall(5)")

    }
}
