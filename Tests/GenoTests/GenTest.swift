import BigInt
import Eth
import XCTest

final class GenTests: XCTestCase {
    func testDecodeContract() async {
        switch try! await Cool.sum(x: BigUInt(1000), y: BigUInt(1000)) {
        case let .success(answer):
            XCTAssertEqual(answer, BigUInt(2000), "additionVmCall(5)")
        case .failure:
            XCTFail()
        }
    }

    func testDecodeCall() async {
        print(try! await Cool.sumDecode(input: Hex("0xcad0899b00000000000000000000000000000000000000000000000000000000000003e800000000000000000000000000000000000000000000000000000000000003e8")))
    }

    func testStructGen() async {
        let bat = try! await Structs.buildBat(x: BigUInt(5), y: BigUInt(3)).get()
        let catData: Hex = "1122334455667788991122334455667788991122334455667788991122334455"
        XCTAssertEqual(bat, Structs.Bat(a: 5, b: 4, c: [
            Structs.Cat(ca: 0, cb: "0x", cc: catData),
            Structs.Cat(ca: -1, cb: "0x00", cc: catData),
            Structs.Cat(ca: -2, cb: "0x0000", cc: catData),
        ], d: "hello", e: [BigUInt(1), BigUInt(1), BigUInt(4)], f: Structs.Cat(ca: 0, cb: "0x", cc: catData)))

        let r = try! await Structs.acceptBat(bat: Structs.Bat(a: BigUInt(1), b: BigUInt(2), c: [Structs.Cat(ca: BigInt(2), cb: "0x01", cc: Hex("bar".data(using: .utf8)!))], d: "Cave", e: [], f: Structs.Cat(ca: 2, cb: "0x00", cc: catData))).get()

        XCTAssertEqual(r, BigInt(-2))

        let addy = EthAddress(Hex("0x673D2EBe4B6BAA946345C7b1F8d3Cc2FfB3429Bf"))!
        let ratAddress = try! await Structs.lookAtRat(rat: Structs.Animal.Rat(a: addy), holes: [addy]).get()
        XCTAssertEqual(ratAddress, addy)

        let moose = try! await Structs.lookAtMoose(moose: [Structs.Animal.Moose(b: 2), Structs.Animal.Moose(b: BigUInt(100_000))], m: 2).get()
        XCTAssertTrue(moose)
    }

    func testGoose() async {
        do {
            let result = try await Structs.emptyGoose()
            XCTAssertNoThrow(result)
        } catch {
            XCTFail("Thrown error: \(error)")
        }

        do {
            let result = try await Structs.anotherEmptyGoose()
            XCTAssertNoThrow(result)
        } catch {
            XCTFail("Thrown error: \(error)")
        }
    }
}
