@testable import Eth
import XCTest
import BigInt

private func word(_ x: Int) -> EthWord {
    guard let ethWord = EthWord(fromBigInt: BigInt(x)) else {
        fatalError("Invalid word in EVMTest \(x)")
    }
    return ethWord
}

private func hexWord(_ data: String) -> EthWord {
    EthWord(hex: data)!
}

final class SarTests: XCTestCase {
    func testSar() throws {
        // EVM.sar
        //             name: "Sar: EIP-145 6",
        //     withCode: [
        //         .push(32, hexWord("0x8000000000000000000000000000000000000000000000000000000000000000")),
        //         .push(4, word(0x0101)),
        //         .sar,
        //         .stop,
        //     ],
        //     expStack: [
        //         "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
        //     ]
        let res = try! EVM.Op.sar(shift: word(0x0101), value:  hexWord("0x8000000000000000000000000000000000000000000000000000000000000000"))
        let out = hexWord("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        XCTAssertEqual(res, out)
    }

    func testSar12() throws {
        let v = hexWord("0x4000000000000000000000000000000000000000000000000000000000000000")
        debugPrint("wtf", v, v.toBigInt())
    
//        let res = try! EVM.Op.sar(shift: word(0xfe), value: v)
//        let out = hexWord("0x0000000000000000000000000000000000000000000000000000000000000001")
//        XCTAssertEqual(res, out)
    }
}
