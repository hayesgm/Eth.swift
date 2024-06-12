import BigInt
import Eth
import XCTest

final class GenTests: XCTestCase {
    func testDecodeContract() {
        XCTAssertEqual(try Cool.sum(x: BigUInt(1000), y: BigUInt(1000)), BigUInt(2000), "additionVmCall(5)")
    }

    func testStructGen() {
        let bat = try! Structs.buildBat(x: BigUInt(5), y: BigUInt(3))
        let catData = Hex.parseHex("1122334455667788991122334455667788991122334455667788991122334455")!
        XCTAssertEqual(bat, Structs.Bat(a: 5, b: 4, c: [
            Structs.Cat(ca: 0, cb: Data(count: 0), cc: catData),
            Structs.Cat(ca: -1, cb: Data(count: 1), cc: catData),
            Structs.Cat(ca: -2, cb: Data(count: 2), cc: catData),
        ], d: "hello", e: [BigUInt(1), BigUInt(1), BigUInt(4)], f: Structs.Cat(ca: 0, cb: Data(count: 0), cc: catData)))

        let r = try! Structs.acceptBat(bat: Structs.Bat(a: BigUInt(1), b: BigUInt(2), c: [Structs.Cat(ca: BigInt(2), cb: Hex.parseHex("1")!, cc: "bar".data(using: .utf8)!)], d: "Cave", e: [], f: Structs.Cat(ca: 2, cb: Data(count: 1), cc: catData)))

        XCTAssertEqual(r, BigInt(-2))
    }
}
