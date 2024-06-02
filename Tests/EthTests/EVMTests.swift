import BigInt
@testable import Eth
import XCTest

private func word(_ data: Int) -> EthWord {
    EthWord(fromBigInt: BigInt(data))!
}

private func runEvmTest(withCode code: EVM.Code, expStack stack: EVM.Stack? = nil, expReturn returnData: Data? = nil, withCallData callData: Data = Data(), withCallValue callValue: BigInt = .zero) throws {
    let input = EVM.CallInput(data: callData, value: callValue)
    let executionResult = try EVM.execVm(code: code, withInput: input)
    if let stack {
        XCTAssertEqual(executionResult.stack, stack)
    }
    if let returnData {
        XCTAssertEqual(executionResult.returnData, returnData)
    }
}

final class EVMTests: XCTestCase {
    func testExecCode() throws {
        try runEvmTest(
            withCode: [
                .push(word(0x11)),
                .push(word(0x22)),
                .add,
                .stop,
            ],
            expStack: [
                word(0x33),
            ]
        )
    }
}
