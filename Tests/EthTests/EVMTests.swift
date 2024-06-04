import BigInt
@testable import Eth
import XCTest

private func word(_ x: Int) -> EthWord {
    guard let ethWord = EthWord(fromBigInt: BigInt(x)) else {
        fatalError("Invalid word in EVMTest \(x)")
    }
    return ethWord
}

private func hex(_ data: String) -> Data {
    Hex.parseHex(data)!
}

struct EvmTest {
    let name: String
    let code: EVM.Code
    let input: EVM.CallInput
    let expStack: EVM.Stack?
    let expReturn: Data?
    let expRevert: Data?
    let expError: EVM.VMError?

    init(name: String, withCode code: EVM.Code, expStack: EVM.Stack? = nil, expReturn: Data? = nil, expRevert: Data? = nil, expError: EVM.VMError? = nil, withCallData callData: Data = Data(), withCallValue callValue: BigUInt = BigUInt(0)) {
        self.name = name
        self.code = code
        input = EVM.CallInput(data: callData, value: callValue)
        self.expStack = expStack
        self.expReturn = expReturn
        self.expRevert = expRevert
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
            do {
                let executionResult = try EVM.execVm(code: code, withInput: input)
                if let stack = expStack {
                    XCTAssertEqual(executionResult.stack, stack, name)
                }
                if let returnData = expReturn {
                    XCTAssert(!executionResult.reverted, "\(name) unexpectedly reverted with data \(Hex.toHex(executionResult.returnData))")
                    XCTAssertEqual(Hex.toHex(executionResult.returnData), Hex.toHex(returnData), name)
                }
                if let returnData = expRevert {
                    XCTAssert(executionResult.reverted, "\(name) was expected to revert, but successfully returned with data \(Hex.toHex(executionResult.returnData))")
                    XCTAssertEqual(Hex.toHex(executionResult.returnData), Hex.toHex(returnData), name)
                }
            } catch let error as EVM.VMError {
                XCTFail("\(name): Unexpected error \(error.localizedDescription)")
            }
        }
    }
}

let tests: [EvmTest] =
    [
        EvmTest(
            name: "Simple Add",
            withCode: [
                .push(32, word(0x11)),
                .push(32, word(0x22)),
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
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffef"),
                .push(32, word(0x22)),
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
                .push(32, word(0x11)),
                .push(32, word(0x22)),
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
                .push(32, word(0x33)),
                .push(32, word(0x22)),
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
                .push(32, word(0x11)),
                .push(32, word(0x03)),
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
                .push(32, word(0x11)),
                .push(32, word(0x33)),
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
                .push(32, word(0x00)),
                .push(32, word(0x33)),
                .div,
                .stop,
            ],
            expStack: [
                word(0x00),
            ]
        ),
        EvmTest(
            name: "Simple SDiv",
            withCode: [
                .push(32, word(-0x11)),
                .push(32, word(-0x33)),
                .sdiv,
                .stop,
            ],
            expStack: [
                word(0x03),
            ]
        ),
        EvmTest(
            name: "Mixed Sign SDiv Denom",
            withCode: [
                .push(32, word(-0x11)),
                .push(32, word(0x33)),
                .sdiv,
                .stop,
            ],
            expStack: [
                word(-0x03),
            ]
        ),
        EvmTest(
            name: "Mixed Sign SDiv Num",
            withCode: [
                .push(32, word(0x11)),
                .push(32, word(-0x33)),
                .sdiv,
                .stop,
            ],
            expStack: [
                word(-0x03),
            ]
        ),
        EvmTest(
            name: "Simple Mod",
            withCode: [
                .push(32, word(5)),
                .push(32, word(33)),
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
                .push(32, word(0)),
                .push(32, word(33)),
                .mod,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Simple SMod Positives",
            withCode: [
                .push(32, word(5)),
                .push(32, word(33)),
                .smod,
                .stop,
            ],
            expStack: [
                word(3),
            ]
        ),
        EvmTest(
            name: "Simple SMod Negatives",
            withCode: [
                .push(32, word(-5)),
                .push(32, word(-33)),
                .smod,
                .stop,
            ],
            expStack: [
                word(-3),
            ]
        ),
        EvmTest(
            name: "Simple SMod Mixed Num",
            withCode: [
                .push(32, word(5)),
                .push(32, word(-33)),
                .smod,
                .stop,
            ],
            expStack: [
                word(-3),
            ]
        ),
        // TODO: Double check this is how this works
        EvmTest(
            name: "Simple SMod Mixed Denom",
            withCode: [
                .push(32, word(-5)),
                .push(32, word(33)),
                .smod,
                .stop,
            ],
            expStack: [
                word(3),
            ]
        ),
        EvmTest(
            name: "Simple SMod Zero",
            withCode: [
                .push(32, word(0)),
                .push(32, word(33)),
                .smod,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "Simple AddMod",
            withCode: [
                .push(32, word(05)),
                .push(32, word(01)),
                .push(32, word(32)),
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
                .push(32, word(05)),
                .push(32, word(03)),
                .push(32, word(11)),
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
                .push(32, word(03)),
                .push(32, word(05)),
                .exp,
                .stop,
            ],
            expStack: [
                word(125),
            ]
        ),
        EvmTest(
            name: "Sign Extend - Byte 0 Negative",
            withCode: [
                .push(32, word(0xFF)),
                .push(32, word(0)),
                .signextend,
                .stop,
            ],
            expStack: [
                "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
            ]
        ),
        EvmTest(
            name: "Sign Extend - Byte 0 Positive",
            withCode: [
                .push(32, word(0x7F)),
                .push(32, word(0)),
                .signextend,
                .stop,
            ],
            expStack: [
                "0x000000000000000000000000000000000000000000000000000000000000007f",
            ]
        ),
        EvmTest(
            name: "Sign Extend - Byte 1 Unset",
            withCode: [
                .push(32, word(0xFF)),
                .push(32, word(1)),
                .signextend,
                .stop,
            ],
            expStack: [
                "0x00000000000000000000000000000000000000000000000000000000000000ff",
            ]
        ),
        EvmTest(
            name: "Sign Extend - Byte 1 Set",
            withCode: [
                .push(32, word(0x8522)),
                .push(32, word(1)),
                .signextend,
                .stop,
            ],
            expStack: [
                "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8522",
            ]
        ),
        EvmTest(
            name: "Sign Extend - Byte 32",
            withCode: [
                .push(32, word(0x8522)),
                .push(32, word(32)),
                .signextend,
                .stop,
            ],
            expStack: [
                word(0x8522),
            ]
        ),
        EvmTest(
            name: "Lt Yes",
            withCode: [
                .push(32, word(04)),
                .push(32, word(03)),
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
                .push(32, word(02)),
                .push(32, word(03)),
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
                .push(32, word(04)),
                .push(32, word(03)),
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
                .push(32, word(02)),
                .push(32, word(03)),
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
                .push(32, word(04)),
                .push(32, word(03)),
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
                .push(32, word(03)),
                .push(32, word(03)),
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
                .push(32, word(0)),
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
                .push(32, word(55)),
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
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
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
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
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
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
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
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00ff"),
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff11"),
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
                .push(32, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff2211"),
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
                .push(32, "0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(32, word(31)),
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
                .push(32, "0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(32, word(30)),
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
                .push(32, "0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(32, word(0)),
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
                .push(32, "0x1100000000000000000000000000000000000000000000000000000000002233"),
                .push(32, word(99)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(0)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(1)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(8)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1111"),
                .push(32, word(255)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(0)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(1)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(8)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(255)),
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
                .push(32, "0xf02233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(255)),
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
                .push(32, "0xf000000000000000000000000000000000000000000000000000000000000000"),
                .push(32, word(4)),
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
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(255)),
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
                .push(32, "0xf02233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(128)),
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
                .push(32, "0xf000000000000000000000000000000000000000000000000000000000000000"),
                .push(32, word(4)),
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
                .push(32, "0x3000000000000000000000000000000000000000000000000000000000000000"),
                .push(32, word(4)),
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
                .push(32, "0xf000000000000000000000000000000000000000000000000000000000000000"),
                .push(32, word(8)),
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
                .push(32, "0x3000000000000000000000000000000000000000000000000000000000000000"),
                .push(32, word(8)),
                .sar,
                .stop,
            ],
            expStack: [
                "0x0030000000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Sha3 Value",
            withCode: [
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(100)),
                .mstore,
                .push(32, word(10)),
                .push(32, word(110)),
                .keccak256,
                .stop,
            ],
            expStack: [
                "0x045e288bf0d99a3c6d375f2346e49d6ea1965518853fca8dbca586ba44775e46",
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
        EvmTest(
            name: "CallDataLoad - Empty",
            withCode: [
                .push(1, word(100)),
                .calldataload,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "CallDataLoad - Set",
            withCode: [
                .push(1, word(5)),
                .calldataload,
                .stop,
            ],
            expStack: [
                "0x1122334455000000000000000000000000000000000000000000000000000000",
            ],
            withCallData: hex("0xbbccddeeff1122334455")
        ),
        EvmTest(
            name: "CallDataSize - Empty",
            withCode: [
                .calldatasize,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "CallDataSize - Set",
            withCode: [
                .calldatasize,
                .stop,
            ],
            expStack: [
                word(10),
            ],
            withCallData: hex("0xbbccddeeff1122334455")
        ),
        EvmTest(
            name: "CallDataCopy - Empty",
            withCode: [
                .push(1, word(5)), // size
                .push(1, word(1)), // offset
                .push(1, word(100)), // destOffset
                .calldatacopy,
                .push(32, word(101)),
                .mload,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "CallDataCopy - Set",
            withCode: [
                .push(1, word(5)), // size
                .push(1, word(1)), // offset
                .push(1, word(100)), // destOffset
                .calldatacopy,
                .push(32, word(101)),
                .mload,
                .stop,
            ],
            expStack: [
                "0xddeeff1100000000000000000000000000000000000000000000000000000000",
            ],
            withCallData: hex("0xbbccddeeff1122334455")
        ),
        EvmTest(
            name: "CodeSize",
            withCode: [
                .codesize,
                .stop,
            ],
            expStack: [
                // TODO: Fix
                word(5),
            ]
        ),
        EvmTest(
            name: "CodeCopy - Set",
            withCode: [
                .push(1, word(5)), // size
                .push(1, word(1)), // offset
                .push(1, word(100)), // destOffset
                .codecopy,
                .push(32, word(101)),
                .mload,
                .stop,
            ],
            expStack: [
                // TODO: Fix
                "0x3344550000000000000000000000000000000000000000000000000000000000",
            ]
        ),
        EvmTest(
            name: "Pop",
            withCode: [
                .push(32, word(1)),
                .pop,
                .stop,
            ],
            expStack: []
        ),
        EvmTest(
            name: "Pop Underflow",
            withCode: [
                .pop,
                .stop,
            ],
            expError: EVM.VMError.stackUnderflow
        ),
        EvmTest(
            name: "MStore -> MLoad",
            withCode: [
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(100)),
                .mstore,
                .push(32, word(110)),
                .mload,
                .stop,
            ],
            expStack: [
                "0xbbccddeeff112233445566778899aabbccddeeff112200000000000000000000",
            ]
        ),
        EvmTest(
            name: "MStore -> MStore8 -> MLoad",
            withCode: [
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(100)),
                .mstore,
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff11fe"),
                .push(32, word(120)),
                .mstore8,
                .push(32, word(110)),
                .mload,
                .stop,
            ],
            expStack: [
                "0xbbccddeeff1122334455fe778899aabbccddeeff112200000000000000000000",
            ]
        ),
        EvmTest(
            name: "Direct Jump - First Path",
            withCode: [
                .push(1, word(3)), // pc = 0
                .jump, //             pc = 2
                .jumpdest, //         pc = 3
                .push(1, word(2)), // pc = 4
                .stop, //             pc = 6
                .jumpdest, //         pc = 7
                .push(1, word(3)), // pc = 8
                .stop, //             pc = 9
            ],
            expStack: [
                word(2),
            ]
        ),
        EvmTest(
            name: "Direct Jump - Second Path",
            withCode: [
                .push(1, word(7)), // pc = 0
                .jump, //             pc = 2
                .jumpdest, //         pc = 3
                .push(1, word(2)), // pc = 4
                .stop, //             pc = 6
                .jumpdest, //         pc = 7
                .push(1, word(3)), // pc = 8
                .stop, //             pc = 9
            ],
            expStack: [
                word(3),
            ]
        ),
        EvmTest(
            name: "Direct Jump - Invalid",
            withCode: [
                .push(1, word(1)), // pc = 0
                .jump, //             pc = 2
                .jumpdest, //         pc = 3
                .push(1, word(2)), // pc = 4
                .stop, //             pc = 6
                .jumpdest, //         pc = 7
                .push(1, word(3)), // pc = 8
                .stop, //             pc = 9
            ],
            expError: EVM.VMError.invalidJumpDest
        ),
        EvmTest(
            name: "Indirect Jump - Jumps",
            withCode: [
                .push(1, word(111)), // pc = 0
                .push(1, word(8)), //   pc = 2
                .jumpi, //              pc = 4
                .push(1, word(2)), //   pc = 5
                .stop, //               pc = 7
                .jumpdest, //           pc = 8
                .push(1, word(3)), //   pc = 9
                .stop, //               pc = a
            ],
            expStack: [
                word(3),
            ]
        ),
        EvmTest(
            name: "Indirect Jump - Fall through",
            withCode: [
                .push(1, word(0)), //   pc = 0
                .push(1, word(8)), //   pc = 2
                .jumpi, //              pc = 4
                .push(1, word(2)), //   pc = 5
                .stop, //               pc = 7
                .jumpdest, //           pc = 8
                .push(1, word(3)), //   pc = 9
                .stop, //               pc = a
            ],
            expStack: [
                word(2),
            ]
        ),
        EvmTest(
            name: "Indirect Jump - Invalid Jump Dest",
            withCode: [
                .push(1, word(1)), //   pc = 0
                .push(1, word(0)), //   pc = 2
                .jumpi, //              pc = 4
                .push(1, word(2)), //   pc = 5
                .stop, //               pc = 7
                .jumpdest, //           pc = 8
                .push(1, word(3)), //   pc = 9
                .stop, //               pc = a
            ],
            expError: EVM.VMError.invalidJumpDest
        ),
        EvmTest(
            name: "PC",
            withCode: [
                .push(1, word(1)), //   pc = 0
                .push(1, word(0)), //   pc = 2
                .pop, //                pc = 4
                .pop, //                pc = 5
                .pc, //                 pc = 6
                .stop,
            ],
            expStack: [
                word(6),
            ]
        ),
        EvmTest(
            name: "MSize - 0",
            withCode: [
                .msize,
                .stop,
            ],
            expStack: [
                word(0),
            ]
        ),
        EvmTest(
            name: "MSize - Sized",
            withCode: [
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(100)),
                .mstore,
                .push(32, word(110)),
                .mload,
                .pop,
                .msize,
                .stop,
            ],
            expStack: [
                word(142),
            ]
        ),
        EvmTest(
            name: "Dup1",
            withCode: [
                .push(32, word(0x100)),
                .push(32, word(0x101)),
                .push(32, word(0x102)),
                .push(32, word(0x103)),
                .dup(1),
                .stop,
            ],
            expStack: [
                word(0x103),
                word(0x103),
                word(0x102),
                word(0x101),
                word(0x100),
            ]
        ),
        EvmTest(
            name: "Dup2",
            withCode: [
                .push(32, word(0x100)),
                .push(32, word(0x101)),
                .push(32, word(0x102)),
                .push(32, word(0x103)),
                .dup(2),
                .stop,
            ],
            expStack: [
                word(0x102),
                word(0x103),
                word(0x102),
                word(0x101),
                word(0x100),
            ]
        ),
        EvmTest(
            name: "Dup - Stack Underflow",
            withCode: [
                .push(32, word(0x100)),
                .push(32, word(0x101)),
                .push(32, word(0x102)),
                .push(32, word(0x103)),
                .dup(10),
                .stop,
            ],
            expError: EVM.VMError.stackUnderflow
        ),
        EvmTest(
            name: "Swap1",
            withCode: [
                .push(32, word(0x100)),
                .push(32, word(0x101)),
                .push(32, word(0x102)),
                .push(32, word(0x103)),
                .swap(1),
                .stop,
            ],
            expStack: [
                word(0x102),
                word(0x103),
                word(0x101),
                word(0x100),
            ]
        ),
        EvmTest(
            name: "Swap2",
            withCode: [
                .push(32, word(0x100)),
                .push(32, word(0x101)),
                .push(32, word(0x102)),
                .push(32, word(0x103)),
                .swap(2),
                .stop,
            ],
            expStack: [
                word(0x101),
                word(0x102),
                word(0x103),
                word(0x100),
            ]
        ),
        EvmTest(
            name: "Swap - Stack Underflow",
            withCode: [
                .push(32, word(0x100)),
                .push(32, word(0x101)),
                .push(32, word(0x102)),
                .push(32, word(0x103)),
                .swap(10),
                .stop,
            ],
            expError: EVM.VMError.stackUnderflow
        ),
        EvmTest(
            name: "Return Value",
            withCode: [
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(100)),
                .mstore,
                .push(32, word(10)),
                .push(32, word(110)),
                .return,
            ],
            expReturn: hex("0xbbccddeeff1122334455")
        ),
        EvmTest(
            name: "Revert Value",
            withCode: [
                .push(32, "0x112233445566778899aabbccddeeff112233445566778899aabbccddeeff1122"),
                .push(32, word(100)),
                .mstore,
                .push(32, word(10)),
                .push(32, word(110)),
                .revert,
            ],
            expRevert: hex("0xbbccddeeff1122334455")
        ),
        EvmTest(
            name: "Invalid",
            withCode: [
                .invalid,
                .stop,
            ],
            expError: EVM.VMError.invalidOperation
        ),
    ]

struct CodeEncodeTest {
    let name: String
    let code: EVM.Code
    let encoding: Data
}

let encodingTests: [CodeEncodeTest] =
    [
        CodeEncodeTest(
            name: "STOP STOP",
            code: [.stop, .stop],
            encoding: hex("0x0000")
        ),
        CodeEncodeTest(
            name: "PUSH6 0x112233445566",
            code: [.push(6, word(0x1122_3344_5566))],
            encoding: hex("0x65112233445566")
        ),
    ]

final class EVMTests: XCTestCase {
    func testRunEvmTests() throws {
        for test in tests {
            try test.runTest()
        }
    }

    func testEncodeCode() throws {
        for encodeTest in encodingTests {
            let encoded = EVM.encodeCode(encodeTest.code)
            XCTAssertEqual(Hex.toHex(encoded), Hex.toHex(encodeTest.encoding), encodeTest.name)
        }
    }

    func testDecodeCode() throws {
        for encodeTest in encodingTests {
            let code = try! EVM.decodeCode(fromData: encodeTest.encoding)
            XCTAssertEqual(code, encodeTest.code, encodeTest.name)
        }
    }
}
