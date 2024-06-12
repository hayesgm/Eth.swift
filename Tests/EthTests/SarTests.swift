import BigInt
@testable import Eth
import XCTest

private func word(_ x: Int) -> EthWord {
    guard let ethWord = EthWord(fromBigInt: BigInt(x)) else {
        fatalError("Invalid word in SARtest \(x)")
    }
    return ethWord
}

private func hexWord(_ data: String) -> EthWord {
    return EthWord(fromHexString: data)!
}

// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-145.md#test-cases
// These are also tested via EVM test
final class SarTests: XCTestCase {
    func testSar6() throws {
        let res = try! EVM.Op.sar(shift: word(0x0101), value: "0x8000000000000000000000000000000000000000000000000000000000000000")
        let out = hexWord("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        XCTAssertEqual(res, out)
    }

    func testSar12() throws {
        let res = try! EVM.Op.sar(shift: word(0x1), value: "0x4000000000000000000000000000000000000000000000000000000000000000")
        let out = hexWord("0x2000000000000000000000000000000000000000000000000000000000000000")
        XCTAssertEqual(res, out)
        let res2 = try! EVM.Op.sar(shift: word(0xFE), value: "0x4000000000000000000000000000000000000000000000000000000000000000")
        let out2 = hexWord("0x0000000000000000000000000000000000000000000000000000000000000001")
        XCTAssertEqual(res2, out2)
    }
}
