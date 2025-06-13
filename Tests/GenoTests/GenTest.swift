import Eth
import SwiftNumber
import XCTest

final class GenTests: XCTestCase {
    func testDecodeContract() {
        switch try! Cool.sum(x: Number(1000), y: Number(1000)) {
        case let .success(answer):
            XCTAssertEqual(answer, Number(2000), "additionVmCall(5)")
        case .failure:
            XCTFail()
        }
    }

    func testDecodeCall() {
        print(try! Cool.sumDecode(input: Hex("0xcad0899b00000000000000000000000000000000000000000000000000000000000003e800000000000000000000000000000000000000000000000000000000000003e8")))
    }

    func testStructGen() {
        let bat = try! Structs.buildBat(x: Number(5), y: Number(3)).get()
        let catData: Hex = "1122334455667788991122334455667788991122334455667788991122334455"
        XCTAssertEqual(bat, Structs.Bat(a: 5, b: 4, c: [
            Structs.Cat(ca: 0, cb: "0x", cc: catData),
            Structs.Cat(ca: -1, cb: "0x00", cc: catData),
            Structs.Cat(ca: -2, cb: "0x0000", cc: catData),
        ], d: "hello", e: [Number(1), Number(1), Number(4)], f: Structs.Cat(ca: 0, cb: "0x", cc: catData), g: [[Hex("0xdeadbeef00000000000000000000000000000000000000000000000000000000")]]))

        let r = try! Structs.acceptBat(bat: Structs.Bat(a: Number(1), b: Number(2), c: [Structs.Cat(ca: SNumber(2), cb: "0x01", cc: Hex("bar".data(using: .utf8)!))], d: "Cave", e: [], f: Structs.Cat(ca: 2, cb: "0x00", cc: catData), g: [[Hex("0xdeadbeef00000000000000000000000000000000000000000000000000000000")]])).get()

        XCTAssertEqual(r, SNumber(-2))

        let addy = EthAddress(Hex("0x673D2EBe4B6BAA946345C7b1F8d3Cc2FfB3429Bf"))!
        let ratAddress = try! Structs.lookAtRat(rat: Structs.Animal.Rat(a: addy), holes: [addy]).get()
        XCTAssertEqual(ratAddress, addy)

        let moose = try! Structs.lookAtMoose(moose: [Structs.Animal.Moose(b: 2), Structs.Animal.Moose(b: Number(100_000))], m: 2).get()
        XCTAssertTrue(moose)
    }

    func testNestedArray() {
        let arr = try! Structs.buildNestedArray(x: Number(5)).get()
        XCTAssertEqual(arr, [[Number(5)]])

        let r = try! Structs.acceptNestedArray(arr: arr).get()

        XCTAssertEqual(r, Number(5))
    }

    func testDat() {
        let dat = try! Structs.buildDat(x: Hex("0xdeadbeef00000000000000000000000000000000000000000000000000000000")).get()
        XCTAssertEqual(dat, Structs.Dat(a: [[Hex("0xdeadbeef00000000000000000000000000000000000000000000000000000000")]], b: [[Hex("0xdeadbeef00000000000000000000000000000000000000000000000000000000")]]))

        let r = try! Structs.acceptDat(x: dat).get()

        XCTAssertEqual(r, Hex("0xdeadbeef00000000000000000000000000000000000000000000000000000000"))
    }

    func testGoose() {
        do {
            let result = try Structs.emptyGoose()
            XCTAssertNoThrow(result)
        } catch {
            XCTFail("Thrown error: \(error)")
        }

        do {
            let result = try Structs.anotherEmptyGoose()
            XCTAssertNoThrow(result)
        } catch {
            XCTFail("Thrown error: \(error)")
        }
    }
}
