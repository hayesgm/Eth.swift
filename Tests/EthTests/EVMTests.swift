import BigInt
@testable import Eth
import XCTest

private func word(_ data: Int) -> EthWord {
    EthWord(fromBigInt: BigInt(data))!
}

struct EvmTest {
    let name: String
    let code: EVM.Code
    let input: EVM.CallInput
    let expStack: EVM.Stack?
    let expReturn: Data?

    init(name: String, withCode code: EVM.Code, expStack: EVM.Stack? = nil, expReturn: Data? = nil, withCallData callData: Data = Data(), withCallValue callValue: BigInt = .zero) {
        self.name = name
        self.code = code
        input = EVM.CallInput(data: callData, value: callValue)
        self.expStack = expStack
        self.expReturn = expReturn
    }

    func runTest() throws {
        let executionResult = try EVM.execVm(code: code, withInput: input)
        if let stack = expStack {
            XCTAssertEqual(executionResult.stack, stack)
        }
        if let returnData = expReturn {
            XCTAssertEqual(executionResult.returnData, returnData)
        }
    }
}

let tests: [EvmTest] =
    [
        EvmTest(
            name: "Simple Add",
            withCode: [
                .push(word(0x11)),
                .push(word(0x22)),
                .add,
                .stop,
            ],
            expStack: [
                word(0x33),
            ]
        ),
        EvmTest(
            name: "Add Overflowing",
            withCode: [
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffef"),
                .push(word(0x22)),
                .add,
                .stop,
            ],
            expStack: [
                word(0x11),
            ]
        ),
        EvmTest(
            name: "Simple Sub",
            withCode: [
                .push(word(0x11)),
                .push(word(0x22)),
                .sub,
                .stop,
            ],
            expStack: [
                word(0x11),
            ]
        ),
        EvmTest(
            name: "Underflowing Sub",
            withCode: [
                .push(word(0x33)),
                .push(word(0x22)),
                .sub,
                .stop,
            ],
            expStack: [
                "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffef",
            ]
        ),
        EvmTest(
            name: "Simple Mul",
            withCode: [
                .push(word(0x11)),
                .push(word(0x03)),
                .mul,
                .stop,
            ],
            expStack: [
                word(0x33),
            ]
        ),
        EvmTest(
            name: "Simple Div",
            withCode: [
                .push(word(0x11)),
                .push(word(0x33)),
                .div,
                .stop,
            ],
            expStack: [
                word(0x03),
            ]
        ),
        EvmTest(
            name: "Simple Div Zero",
            withCode: [
                .push(word(0x00)),
                .push(word(0x33)),
                .div,
                .stop,
            ],
            expStack: [
                word(0x00),
            ]
        ),
    ]

final class EVMTests: XCTestCase {
    func testRunEvmTests() throws {
        for test in tests {
            try test.runTest()
        }
    }
}
