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
    let expError: EVM.VMError?

    init(name: String, withCode code: EVM.Code, expStack: EVM.Stack? = nil, expReturn: Data? = nil, expError: EVM.VMError? = nil, withCallData callData: Data = Data(), withCallValue callValue: BigUInt = BigUInt(0)) {
        self.name = name
        self.code = code
        input = EVM.CallInput(data: callData, value: callValue)
        self.expStack = expStack
        self.expReturn = expReturn
        self.expError = expError
    }

    func runTest() throws {
        if let expError {
            do {
                _ = try EVM.execVm(code: code, withInput: input)
                XCTFail("\(name): Expected error \(expError.localizedDescription), none received")
            } catch let error as EVM.VMError {
                XCTAssertEqual(error, expError)
            }
        } else {
            let executionResult = try EVM.execVm(code: code, withInput: input)
            if let stack = expStack {
                XCTAssertEqual(executionResult.stack, stack, name)
            }
            if let returnData = expReturn {
                XCTAssertEqual(executionResult.returnData, returnData, name)
            }
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
        EvmTest(
            name: "Shl[0]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(0)),
                .shl,
                .stop,
            ],
            expStack: [
                "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122",
            ]
        ),
        EvmTest(
            name: "Shl[1]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(1)),
                .shl,
                .stop,
            ],
            expStack: [
                "0x22446688aaccef1133557799bbddfe22446688aaccef1133557799bbddfe2244",
            ]
        ),
        EvmTest(
            name: "Shl[8]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(8)),
                .shl,
                .stop,
            ],
            expStack: [
                "0x2233445566778899aabbccddeeff112233445566778899aabbccddeeff112200",
            ]
        ),
        EvmTest(
            name: "Shl[255]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1111"),
                .push(word(255)),
                .shl,
                .stop,
            ],
            expStack: [
                "0x8000000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Shr[0]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(0)),
                .shr,
                .stop,
            ],
            expStack: [
                "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122",
            ]
        ),
        EvmTest(
            name: "Shr[1]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(1)),
                .shr,
                .stop,
            ],
            expStack: [
                "0x089119a22ab33bc44cd55de66ef77f889119a22ab33bc44cd55de66ef77f8891",
            ]
        ),
        EvmTest(
            name: "Shr[8]",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(8)),
                .shr,
                .stop,
            ],
            expStack: [
                "0x00112233445566778899aabbccddeeff112233445566778899aabbccddeeff11",
            ]
        ),
        EvmTest(
            name: "Shr[255] MSB=0x11",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(255)),
                .shr,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Shr[255] MSB=0xF0",
            withCode: [
                .push("0xf02233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(255)),
                .shr,
                .stop,
            ],
            expStack: [
                word(1),
            ]
        ),
        EvmTest(
            name: "Shr[4] MSB=0xF0",
            withCode: [
                .push("0xf000000000000000000000000000000000000000000000000000000000000000"),
                .push(word(4)),
                .shr,
                .stop,
            ],
            expStack: [
                "0x0f00000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Sar[255] MSB=0x11",
            withCode: [
                .push("0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(255)),
                .sar,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        // TODO: I think this is off
        EvmTest(
            name: "Sar[255] MSB=0xF0",
            withCode: [
                .push("0xf02233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(word(128)),
                .sar,
                .stop,
            ],
            expStack: [
                "0x3ffffffffffffffffffffffffffffffff02233445566778899aabbccddeeff11",
            ]
        ),
        EvmTest(
            name: "Sar[4] MSB=0xF0",
            withCode: [
                .push("0xf000000000000000000000000000000000000000000000000000000000000000"),
                .push(word(4)),
                .sar,
                .stop,
            ],
            expStack: [
                "0xff00000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Sar[4] MSB=0x30",
            withCode: [
                .push("0x3000000000000000000000000000000000000000000000000000000000000000"),
                .push(word(4)),
                .sar,
                .stop,
            ],
            expStack: [
                "0x0300000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Sar[8] MSB=0xF0",
            withCode: [
                .push("0xf000000000000000000000000000000000000000000000000000000000000000"),
                .push(word(8)),
                .sar,
                .stop,
            ],
            expStack: [
                "0xfff0000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Sar[8] MSB=0x30",
            withCode: [
                .push("0x3000000000000000000000000000000000000000000000000000000000000000"),
                .push(word(8)),
                .sar,
                .stop,
            ],
            expStack: [
                "0x0030000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Address",
            withCode: [
                .address,
            ],
            expError: EVM.VMError.impure(.address)
        ),
        EvmTest(
            name: "Balance",
            withCode: [
                .balance,
            ],
            expError: EVM.VMError.impure(.balance)
        ),
        EvmTest(
            name: "Origin",
            withCode: [
                .origin,
            ],
            expError: EVM.VMError.impure(.origin)
        ),
        EvmTest(
            name: "Caller",
            withCode: [
                .caller,
            ],
            expError: EVM.VMError.impure(.caller)
        ),
        EvmTest(
            name: "CallValue 0",
            withCode: [
                .callvalue,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "CallValue 55",
            withCode: [
                .callvalue,
                .stop,
            ],
            expStack: [
                word(55),
            ],
            withCallValue: BigUInt(55)
        ),
    ]

final class EVMTests: XCTestCase {
    func testRunEvmTests() throws {
        for test in tests {
            try test.runTest()
        }
    }
}
