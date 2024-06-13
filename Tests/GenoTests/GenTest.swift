import BigInt
import Eth
import XCTest

final class GenTests: XCTestCase {
    func testDecodeContract() {
        XCTAssertEqual(try Cool.sum(x: BigUInt(1000), y: BigUInt(1000)), BigUInt(2000), "additionVmCall(5)")
    }

    func testStructGen() {
        let bat = try! Structs.buildBat(x: BigUInt(5), y: BigUInt(3))
        let catData: Hex = "1122334455667788991122334455667788991122334455667788991122334455"
        XCTAssertEqual(bat, Structs.Bat(a: 5, b: 4, c: [
            Structs.Cat(ca: 0, cb: "0x", cc: catData),
            Structs.Cat(ca: -1, cb: "0x00", cc: catData),
            Structs.Cat(ca: -2, cb: "0x0000", cc: catData),
        ], d: "hello", e: [BigUInt(1), BigUInt(1), BigUInt(4)], f: Structs.Cat(ca: 0, cb: "0x", cc: catData)))

        let r = try! Structs.acceptBat(bat: Structs.Bat(a: BigUInt(1), b: BigUInt(2), c: [Structs.Cat(ca: BigInt(2), cb: "0x01", cc: Hex("bar".data(using: .utf8)!))], d: "Cave", e: [], f: Structs.Cat(ca: 2, cb: "0x00", cc: catData)))

        XCTAssertEqual(r, BigInt(-2))
    }

    func testErrorHandling() {
        var vibe = false
        do {
            _ = try Cool.vibeCheck(status: BigUInt(75))
        } catch let EVM.QueryError.error(Cool.LukeWarmError, .tuple1(isVibin)) {
            vibe = isVibin.asBool!
        } catch {
            vibe = false
        }

        XCTAssertTrue(vibe, "warm vibe")
    }
}
