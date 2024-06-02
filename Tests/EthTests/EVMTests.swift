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
        // TODO: SDiv
        EvmTest(
            name: "Simple Mod",
            withCode: [
                .push(word(5)),
                .push(word(33)),
                .mod,
                .stop,
            ],
            expStack: [
                word(3),
            ]
        ),
        EvmTest(
            name: "Simple Mod Zero",
            withCode: [
                .push(word(0)),
                .push(word(33)),
                .mod,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        // TODO: SMod
        EvmTest(
            name: "Simple AddMod",
            withCode: [
                .push(word(05)),
                .push(word(01)),
                .push(word(32)),
                .addmod,
                .stop,
            ],
            expStack: [
                word(03),
            ]
        ),
        EvmTest(
            name: "Simple MulMod",
            withCode: [
                .push(word(05)),
                .push(word(03)),
                .push(word(11)),
                .mulmod,
                .stop,
            ],
            expStack: [
                word(03),
            ]
        ),
        EvmTest(
            name: "Simple Exp",
            withCode: [
                .push(word(03)),
                .push(word(05)),
                .exp,
                .stop,
            ],
            expStack: [
                word(125),
            ]
        ),
        // TODO: Sign Extend
        EvmTest(
            name: "Lt Yes",
            withCode: [
                .push(word(04)),
                .push(word(03)),
                .lt,
                .stop,
            ],
            expStack: [
                word(1),
            ]
        ),
        EvmTest(
            name: "Lt No",
            withCode: [
                .push(word(02)),
                .push(word(03)),
                .lt,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Gt No",
            withCode: [
                .push(word(04)),
                .push(word(03)),
                .gt,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Gt Yes",
            withCode: [
                .push(word(02)),
                .push(word(03)),
                .gt,
                .stop,
            ],
            expStack: [
                word(1),
            ]
        ),
        // TODO: SLT
        // TODO: SGT
        EvmTest(
            name: "Eq No",
            withCode: [
                .push(word(04)),
                .push(word(03)),
                .eq,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Eq Yes",
            withCode: [
                .push(word(03)),
                .push(word(03)),
                .eq,
                .stop,
            ],
            expStack: [
                word(1),
            ]
        ),
        EvmTest(
            name: "IsZero Yes",
            withCode: [
                .push(word(0)),
                .iszero,
                .stop,
            ],
            expStack: [
                word(1),
            ]
        ),
        EvmTest(
            name: "IsZero No",
            withCode: [
                .push(word(55)),
                .iszero,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Binary And",
            withCode: [
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
                .and,
                .stop,
            ],
            expStack: [
                "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0011",
            ]
        ),
        EvmTest(
            name: "Binary Or",
            withCode: [
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
                .or,
                .stop,
            ],
            expStack: [
                "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
            ]
        ),
        EvmTest(
            name: "Binary Or",
            withCode: [
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
                .or,
                .stop,
            ],
            expStack: [
                "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
            ]
        ),
        EvmTest(
            name: "Binary Xor",
            withCode: [
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
                .xor,
                .stop,
            ],
            expStack: [
                "0x000000000000000000000000000000000000000000000000000000000000ffee",
            ]
        ),
        EvmTest(
            name: "Binary Not",
            withCode: [
                .push("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff2211"),
                .not,
                .stop,
            ],
            expStack: [
                "0x000000000000000000000000000000000000000000000000000000000000ddee",
            ]
        ),
        EvmTest(
            name: "Byte 31",
            withCode: [
                .push("0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(word(31)),
                .byte,
                .stop,
            ],
            expStack: [
                word(0x33),
            ]
        ),
        EvmTest(
            name: "Byte 30",
            withCode: [
                .push("0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(word(30)),
                .byte,
                .stop,
            ],
            expStack: [
                word(0x22),
            ]
        ),
        EvmTest(
            name: "Byte 0",
            withCode: [
                .push("0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(word(0)),
                .byte,
                .stop,
            ],
            expStack: [
                word(0x11),
            ]
        ),
        EvmTest(
            name: "Byte 99",
            withCode: [
                .push("0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(word(99)),
                .byte,
                .stop,
            ],
            expStack: [
                word(0x0),
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
