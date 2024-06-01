@testable import Eth
import XCTest

final class EVMTests: XCTestCase {
    func testExecCode() throws {
        let code = [
            .push(EthWord(hexExtending: "0x11")),
            .push(EthWord(hexExtending: "0x22")),
            .add,
        ]
        let executionResult = EVM.execVm(code: code, withInputs: inputs)!
        XCTAssertEqual(executionResult, ExecutionResult(stack: [], returnData: Data()))
    }
}
