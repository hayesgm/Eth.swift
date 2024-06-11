import BigInt
import XCTest

final class CoolGenTests: XCTestCase {
    func testDecodeContract() {
        XCTAssertEqual(try Cool.sum(x: BigUInt(1000), y: BigUInt(1000)), BigUInt(2000), "Cool.sum(1000,1000)")
    }
}
