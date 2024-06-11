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

private func hexes(_ items: [Any]) -> Data {
    return items.map { v in
        if let v = v as? Int {
            return word(v).data
        } else if let v = v as? String {
            if let hex = Hex.parseHex(v) {
                return hex
            } else {
                if let enc = v.data(using: .utf8) {
                    return enc + Data(repeating: 0, count: 32 - enc.count)
                } else {
                    fatalError("Failed to encode string to data: \(v)")
                }
            }
        } else if let v = v as? Data {
            return v + Data(repeating: 0, count: 32 - v.count)
        } else if let v = v as? EthWord {
            return v.data
        } else {
            fatalError("Unknown hexes value: \(v)")
        }
    }.reduce(Data()) { $0 + $1 }
}

struct CodingTest {
    let name: String
    let input: ABI.Field
    let encoded: Data
    let expectedDecodeError: ABI.DecodeError?
    let only: Bool

    init(name: String, input: ABI.Field, encoded: Data, only: Bool = false) {
        self.name = name
        self.input = input
        self.encoded = encoded
        expectedDecodeError = nil
        self.only = only
    }

    init(input: ABI.Field, encoded: Data, only: Bool = false) {
        name = input.description
        self.input = input
        self.encoded = encoded
        expectedDecodeError = nil
        self.only = only
    }

    init(name _: String, input: ABI.Field, encoded: Data, expError expectedDecodeError: ABI.DecodeError, only: Bool = false) {
        name = "[DecodeTest] \(input.description)"
        self.input = input
        self.encoded = encoded
        self.expectedDecodeError = expectedDecodeError
        self.only = only
    }
}

let codingTests: [CodingTest] =
    [
        CodingTest(
            input: .uint8(0x37),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000037")
        ),
        CodingTest(
            name: "Unsigned Integer Overflow",
            input: .uint8(0x137),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000137"),
            expError: ABI.DecodeError.sizedUnsignedIntegerOverflow(8, hex("0x0000000000000000000000000000000000000000000000000000000000000137"))
        ),

        CodingTest(
            input: .int8(0x37),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000037")
        ),
        CodingTest(
            input: .int8(-0x02),
            encoded: hex("0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe")
        ),
        CodingTest(
            input: .int16(-257),
            encoded: hex("0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeff")
        ),
        CodingTest(
            name: "Signed Integer Overflow Negative",
            input: .int8(-257),
            encoded: hex("0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeff"),
            expError: ABI.DecodeError.sizedSignedIntegerOverflow(8, hex("0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeff"))
        ),
        CodingTest(
            name: "Signed Integer Overflow Positive",
            input: .int8(0x137),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000137"),
            expError: ABI.DecodeError.sizedSignedIntegerOverflow(8, hex("0x0000000000000000000000000000000000000000000000000000000000000137"))
        ),
        CodingTest(
            name: "Too Little data",
            input: .uint8(0x37),
            encoded: hex("0x1122"),
            expError: ABI.DecodeError.insufficientData(.uint8, hex("0x1122"))
        ),
        CodingTest(
            name: "Too Much data",
            input: .uint8(0x37),
            encoded: hexes([word(1), word(2)]),
            expError: ABI.DecodeError.excessData(.uint8, hex("0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002"))
        ),
        CodingTest(
            input: .string("hello"),
            encoded: hex("0x000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "String minor overflow",
            input: .string("hello"),
            encoded: hex("0x000000000000000000000000000000000000000000000000000000000000003368656c6c6f000000000000000000000000000000000000000000000000000000"),
            expError: ABI.DecodeError.insufficientData(.string, hex("0x68656c6c6f000000000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "String mega overflow",
            input: .string("hello"),
            encoded: hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff68656c6c6f000000000000000000000000000000000000000000000000000000"),
            expError: ABI.DecodeError.integerOverflow(.string, hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"))
        ),
        CodingTest(
            name: "String no data",
            input: .string("hello"),
            encoded: hex(""),
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.insufficientData(.string, hex(""))
        ),
        CodingTest(
            name: "String too few words",
            input: .string("hello"),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000005"),
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.insufficientData(.string, hex(""))
        ),
        CodingTest(
            name: "String too much data",
            input: .string("hello"),
            encoded: hex("0x000000000000000000000000000000000000000000000000000000000000000568656c6c6f00000000000000000000000000000000000000000000000000000011"),
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.excessData(.string, hex("0x68656c6c6f00000000000000000000000000000000000000000000000000000011"))
        ),
        CodingTest(
            name: "String length too big",
            input: .string("hello"),
            encoded: hex("0xff00000000000000000000000000000000000000000000000000000000000000"),
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.integerOverflow(.string, hex("0xff00000000000000000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "Static Tuple",
            input: .tuple2(.uint8(0x37), .uint8(0x38)),
            encoded: hex("0x00000000000000000000000000000000000000000000000000000000000000370000000000000000000000000000000000000000000000000000000000000038")
        ),
        CodingTest(
            name: "Dynamic Tuple",
            input: .tuple2(.uint8(0x55), .string("hello")),
            encoded: hexes([0x55, 0x40, /* Heap (0x40) */ 0x05, "hello"])
        ),
        CodingTest(
            name: "Bytes",
            input: .bytes(hex("0x5566")),
            encoded: hexes([0x02, hex("0x5566")])
        ),
        CodingTest(
            name: "Bytes (2 Words)",
            input: .bytes(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff112233")),
            encoded: hexes([0x23, hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), hex("0x112233")])
        ),
        CodingTest(
            name: "Tuple(Bytes)",
            input: .tuple1(.bytes(hex("0x5566"))),
            encoded: hexes([0x20, /* Heap (0x20) */ 0x02, hex("0x5566")])
        ),
        CodingTest(
            name: "Bytes - Mega Overflow",
            input: .bytes(hex("0xff")),
            encoded: hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff68656c6c6f000000000000000000000000000000000000000000000000000000"),
            expError: ABI.DecodeError.integerOverflow(.bytes, hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"))
        ),
        CodingTest(
            name: "Tuple(Bytes) - minor overflow",
            input: .tuple1(.bytes(Data())),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003368656c6c6f000000000000000000000000000000000000000000000000000000"),
            expError: ABI.DecodeError.insufficientData(.bytes, hex("0x68656c6c6f000000000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "Tuple(Bytes) mega overflow",
            input: .tuple1(.bytes(Data())),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000020ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff68656c6c6f000000000000000000000000000000000000000000000000000000"),
            expError: ABI.DecodeError.integerOverflow(.bytes, hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"))
        ),
        CodingTest(
            name: "Bytes1",
            input: .bytes1(hex("0x55")),
            encoded: hex("0x5500000000000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "Overflow Bytes1",
            input: .bytes1(hex("0x55")),
            encoded: hex("0x55FF000000000000000000000000000000000000000000000000000000000000"),
            expError: ABI.DecodeError.nonEmptyDataFound(.bytes1, hex("0x55FF000000000000000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "Bytes2",
            input: .bytes2(hex("0x55DD")),
            encoded: hex("0x55DD000000000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            input: .bytes32(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")),
            encoded: hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        ),
        CodingTest(
            name: "Bool True",
            input: .bool(true),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000001")
        ),
        CodingTest(
            name: "Bool False",
            input: .bool(false),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "Bool Overflow",
            input: .bool(true),
            encoded: hex("0x0000000000000000000000000000000000000000000000000000000000000002"),
            expError: ABI.DecodeError.sizedUnsignedIntegerOverflow(1, hex("0x0000000000000000000000000000000000000000000000000000000000000002"))
        ),
        CodingTest(
            name: "Address",
            input: .address(EthAddress("0x1000000000000000000000000000000000000002")),
            encoded: hex("0x0000000000000000000000001000000000000000000000000000000000000002")
        ),
        CodingTest(
            name: "Address Non-Empty Data",
            input: .address(EthAddress("0x1000000000000000000000000000000000000002")),
            encoded: hex("0x1100000000000000000000001000000000000000000000000000000000000002"),
            expError: ABI.DecodeError.nonEmptyDataFound(.address, hex("0x1100000000000000000000001000000000000000000000000000000000000002"))
        ),
        CodingTest(
            name: "Variable-Length Array with Static Elements",
            input: .array(.uint8, [.uint8(0x55), .uint8(0x56)]),
            encoded: hexes([0x02, 0x55, 0x56])
        ),
        CodingTest(
            name: "Variable-Length Array with Static Elements - Empty",
            input: .array(.uint8, []),
            encoded: hexes([0x00])
        ),
        CodingTest(
            name: "Variable-Length Array with Static Elements - InsufficientData",
            input: .array(.uint8, []),
            encoded: hexes(["0x000000000000000000000000000000000000000000000000000000000000"]),
            expError: ABI.DecodeError.insufficientData(.uint8, hex("0x000000000000000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "Variable-Length Array with Dynamic Elements",
            input: .array(.string, [.string("xxx"), .string("yyyy")]),
            encoded: hexes([0x02, 0x40, 0x80, /* Heap (0x40) */ 0x3, "xxx", 0x04, "yyyy"])
        ),
        CodingTest(
            name: "Variable-Length Array with Dynamic Elements - Empty",
            input: .array(.string, []),
            encoded: hexes([0x00])
        ),
        CodingTest(
            name: "Array of Arrays",
            input: .array(.array(.string), [
                .array(.string, [.string("xxx"), .string("yyyy")]),
                .array(.string, [.string("zz")]),
                .array(.string, []),
            ]),
            encoded: hexes([
                0x03, /* Top-level Array Element Count */
                0x60, /* Top-level Element 1 Pointer */
                0x140, /* Top-level Element 2 Pointer */
                0x1C0, /* Top-level Element 3 Pointer */
                0x02, /* Inner Element 1 - Element Count */
                0x40, /* Inner Element 1 - Element 1 Pointer */
                0x80, /* Inner Element 1 - Element 2 Pointer */
                0x03, /* Inner Element 1 - Element 1 String Len */
                "xxx", /* Inner Element 1 - Element 1 String */
                0x04, /* Inner Element 1 - Element 2 String Len */
                "yyyy", /* Inner Element 1 - Element 2 String */
                0x01, /* Inner Element 2 - Element Count */
                0x20, /* Inner Element 2 - Element 1 Pointer */
                0x02, /* Inner Element 2 - Element 1 String Len */
                "zz", /* Inner Element 2 - Element 1 String */
                0x00, /* Inner Element 3 - Element Count */
            ])
        ),
        CodingTest(
            name: "Tuple of Variable-Length Array with Static Elements",
            input: .tuple1(.array(.uint8, [.uint8(0x55), .uint8(0x56)])),
            encoded: hexes([0x20, 0x02, 0x55, 0x56])
        ),
        CodingTest(
            name: "Tuple of Variable-Length Array with Dynamic Elements",
            input: .tuple1(.array(.string, [.string("xxx"), .string("yyyy")])),
            encoded: hexes([0x20, 0x02, 0x40, 0x80, /* Heap (0x40) */ 0x3, "xxx", 0x04, "yyyy"])
        ),
        CodingTest(
            name: "Static Single Tuple",
            input: .tuple1(.uint256(BigUInt(0x07D0))),
            encoded: hex("0x00000000000000000000000000000000000000000000000000000000000007d0")
        ),
        CodingTest(
            name: "Static Expanded Tuple",
            input: .tuple3(.uint8(0x55), .tuple2(.uint8(0x01), .uint8(0x02)), .string("hello")),
            encoded: hexes([0x55, 0x01, 0x02, 0x80, /* Heap (0x80) */ 0x05, "hello"])
        ),
        CodingTest(
            name: "Nested Dynamic Tuple",
            input: .tuple3(.uint8(0x55), .tuple3(.uint8(0x01), .uint8(0x02), .string("what")), .string("hello")),
            encoded: hexes([
                0x55,
                0x60,
                0x100,
                /* Heap (0x60) */
                0x01,
                0x02,
                0x60,
                /* Heap 2 (0x60) */
                0x04,
                "what",
                0x05,
                "hello",
            ])
        ),
        CodingTest(
            name: "Tuple - Invalid Data Pointer - Out of Data",
            input: .tuple2(.string("hello"), .string("goodbye")),
            encoded: hexes([
                0x40,
                0x100,
                0x05,
                "hello",
                0x07,
                "goodbye",
            ]),
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x100, hex("0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000568656c6c6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007676f6f6462796500000000000000000000000000000000000000000000000000")),
            only: true
        ),
        CodingTest(
            name: "Tuple - Invalid Data Pointer - Backwards",
            input: .tuple2(.string("hello"), .string("goodbye")),
            encoded: hexes([
                0x40,
                0x20,
                0x05,
                "hello",
                0x07,
                "goodbye",
            ]),
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x20, hex("0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000568656c6c6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007676f6f6462796500000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "Tuple - Invalid Data Pointer - Repeat Data",
            input: .tuple2(.string("hello"), .string("goodbye")),
            encoded: hexes([
                0x40,
                0x40,
                0x05,
                "hello",
            ]),
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x40, hex("0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000"))
        ),
        CodingTest(
            name: "Tuple - Invalid Data Pointer - Invalid Alignment",
            input: .tuple2(.string("hello"), .string("goodbye")),
            encoded: hexes([
                0x40,
                0x81,
                0x05,
                "hello",
                0x07,
                "goodbye",
            ]),
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x81, hex("0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000081000000000000000000000000000000000000000000000000000000000000000568656c6c6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007676f6f6462796500000000000000000000000000000000000000000000000000"))
        ),
    ]

func showEncoded(_ encoded: Data) -> String {
    "ABI Encoded ⬇️\n\n\t\t\(EthUtil.showChunkedWords(encoded))\n\n"
}

func jsonValue(field: ABI.Field) -> String {
    switch field {
    case let .uint8(v), let .uint16(v), let .uint24(v), let .uint32(v):
        return v.description
    case let .uint40(v), let .uint48(v), let .uint56(v), let .uint64(v), let .uint72(v), let .uint80(v), let .uint88(v), let .uint96(v), let .uint104(v), let .uint112(v), let .uint120(v), let .uint128(v), let .uint136(v), let .uint144(v), let .uint152(v), let .uint160(v), let .uint168(v), let .uint176(v), let .uint184(v), let .uint192(v), let .uint200(v), let .uint208(v), let .uint216(v), let .uint224(v), let .uint232(v), let .uint240(v), let .uint248(v), let .uint256(v):
        return v.description
    case let .int8(v), let .int16(v), let .int24(v), let .int32(v):
        return v.description
    case let .int40(v), let .int48(v), let .int56(v), let .int64(v), let .int72(v), let .int80(v), let .int88(v), let .int96(v), let .int104(v), let .int112(v), let .int120(v), let .int128(v), let .int136(v), let .int144(v), let .int152(v), let .int160(v), let .int168(v), let .int176(v), let .int184(v), let .int192(v), let .int200(v), let .int208(v), let .int216(v), let .int224(v), let .int232(v), let .int240(v), let .int248(v), let .int256(v):
        return v.description
    case let .bool(v):
        return v.description
    case let .address(v):
        return "\"\(Hex.toHex(v.address))\""
    case let .bytes(d):
        return "\"\(Hex.toHex(d))\""
    case let .bytes1(d), let .bytes2(d), let .bytes3(d), let .bytes4(d), let .bytes5(d), let .bytes6(d), let .bytes7(d), let .bytes8(d), let .bytes9(d), let .bytes10(d), let .bytes11(d), let .bytes12(d), let .bytes13(d), let .bytes14(d), let .bytes15(d), let .bytes16(d), let .bytes17(d), let .bytes18(d), let .bytes19(d), let .bytes20(d), let .bytes21(d), let .bytes22(d), let .bytes23(d), let .bytes24(d), let .bytes25(d), let .bytes26(d), let .bytes27(d), let .bytes28(d), let .bytes29(d), let .bytes30(d), let .bytes31(d), let .bytes32(d):
        return "\"\(Hex.toHex(d))\""
    case let .string(v):
        return "\"\(v.description)\""
    case let .array(_, v):
        return "'[\(v.map { jsonValue(field: $0) }.joined(separator: ","))]'"
    case let .arrayN(_, _, v):
        return "'[\(v.map { jsonValue(field: $0) }.joined(separator: ","))]'"
    case let .tupleN(v):
        return "'(\(v.map { jsonValue(field: $0) }.joined(separator: ",")))'"
    case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16:
        return jsonValue(field: field.asTupleN!)
    }
}

func showHelp(_ field: ABI.Field) -> String? {
    switch field {
    case let .tupleN(fields):
        let fieldTypeStrings = fields.map { $0.fieldType.description }.joined(separator: ", ")
        let fieldValueStrings = fields.map { jsonValue(field: $0) }.joined(separator: " ")
        return " - Compare to `cast abi-encode 'tuple(\(fieldTypeStrings))' \(fieldValueStrings)`"
    case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10:
        return showHelp(field.asTupleN!)
    default:
        return nil
    }
}

struct FunctionTest {
    let name: String
    let function: ABI.Function
    let fields: [ABI.Field]
    let encoded: Data
    let expectedFunctionError: ABI.FunctionError?
    let expectedDecodeError: ABI.DecodeError?

    init(name: String, function: ABI.Function, fields: [ABI.Field], encoded: Data) {
        self.name = name
        self.function = function
        self.fields = fields
        self.encoded = encoded
        expectedFunctionError = nil
        expectedDecodeError = nil
    }

    init(function: ABI.Function, fields: [ABI.Field], encoded: Data) {
        name = function.signature
        self.function = function
        self.fields = fields
        self.encoded = encoded
        expectedFunctionError = nil
        expectedDecodeError = nil
    }

    // init(input: ABI.Field, encoded: Data) {
    //     name = input.description
    //     self.input = input
    //     self.encoded = encoded
    //     expectedDecodeError = nil
    // }

    // init(name _: String, input: ABI.Field, encoded: Data, expError expectedDecodeError: ABI.DecodeError) {
    //     name = "[DecodeTest] \(input.description)"
    //     self.input = input
    //     self.encoded = encoded
    //     self.expectedDecodeError = expectedDecodeError
    // }
}

let functionTests = [
    FunctionTest(
        function: ABI.Function(
            name: "cool",
            inputs: [.uint8],
            outputs: []
        ),
        fields: [.uint8(0x37)],
        encoded: hex("0xa8cb34810000000000000000000000000000000000000000000000000000000000000037")
    ),
    FunctionTest(
        function: ABI.Function(
            name: "cool",
            inputs: [.uint8, .tuple([.uint8, .string, .uint8])],
            outputs: []
        ),
        fields: [.uint8(19), .tuple3(.uint8(22), .string("hello"), .uint8(33))],
        encoded: hex("0xcd4d69f600000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000001600000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000021000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000")
    ),
]

final class ABITests: XCTestCase {
    private func getCodingTests() -> [CodingTest] {
        return codingTests.contains { $0.only } ? codingTests.filter { $0.only } : codingTests
    }

    func testStringEncodingIssue() throws {
        // There's lots of things that tried to fail here, but it mostly just works or crashes at compilation
        let invalidUTF8Data = Data([0xC3, 0x28]) // Invalid UTF-8 sequence
        let invalidNSString = NSString(data: invalidUTF8Data, encoding: String.Encoding.ascii.rawValue)
        let invalidString = invalidNSString as String?

        XCTAssertEqual(Hex.toHex(ABI.Field.string(invalidString!).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000000000000003c383280000000000000000000000000000000000000000000000000000000000")))
    }

    func testSmallUIntClamped() throws {
        XCTAssertEqual(Hex.toHex(ABI.Field.uint8(300).encoded), Hex.toHex(hex("0x00000000000000000000000000000000000000000000000000000000000000ff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.uint16(0x10000).encoded), Hex.toHex(hex("0x000000000000000000000000000000000000000000000000000000000000ffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.uint24(0x1000000).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000000000ffffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.uint32(0x1_0000_0000).encoded), Hex.toHex(hex("0x00000000000000000000000000000000000000000000000000000000ffffffff")))
    }

    func testLargeUIntClamped() throws {
        XCTAssertEqual(Hex.toHex(ABI.Field.uint40(BigUInt(1) << 39).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000008000000000")))
        XCTAssertEqual(Hex.toHex(ABI.Field.uint40(BigUInt(1) << 41).encoded), Hex.toHex(hex("0x000000000000000000000000000000000000000000000000000000ffffffffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.uint256(BigUInt(1) << 257).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")))
    }

    func testSmallIntClamped() throws {
        XCTAssertEqual(Hex.toHex(ABI.Field.int8(100).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000000000000064")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int8(200).encoded), Hex.toHex(hex("0x000000000000000000000000000000000000000000000000000000000000007f")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int8(-200).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff80")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int16(99999).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000000000007fff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int16(-99999).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8000")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int24(0x1000000).encoded), Hex.toHex(hex("0x00000000000000000000000000000000000000000000000000000000007fffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int24(-0x1000000).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffff800000")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int32(0x1_0000_0000).encoded), Hex.toHex(hex("0x000000000000000000000000000000000000000000000000000000007fffffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int32(-0x1_0000_0000).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff80000000")))
    }

    func testLargeIntClamped() throws {
        XCTAssertEqual(Hex.toHex(ABI.Field.int40(BigInt(1) << 38).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000004000000000")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int40(-(BigInt(1) << 38)).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffc000000000")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int40(BigInt(1) << 41).encoded), Hex.toHex(hex("0x0000000000000000000000000000000000000000000000000000007fffffffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int40(-(BigInt(1) << 41)).encoded), Hex.toHex(hex("0xffffffffffffffffffffffffffffffffffffffffffffffffffffff8000000000")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int256(BigInt(1) << 257).encoded), Hex.toHex(hex("0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")))
        XCTAssertEqual(Hex.toHex(ABI.Field.int256(-(BigInt(1) << 257)).encoded), Hex.toHex(hex("0x8000000000000000000000000000000000000000000000000000000000000000")))
    }

    func testUnwrappingFunctions() throws {
        XCTAssertEqual(ABI.Field.string("hello").asString, "hello")
        XCTAssertEqual(ABI.Field.uint8(22).asString, nil)
        XCTAssertEqual(ABI.Field.uint8(22).asUInt, 22)
        XCTAssertEqual(ABI.Field.uint8(22).asInt, nil)
        XCTAssertEqual(ABI.Field.uint8(22).asBigInt, nil)
        XCTAssertEqual(ABI.Field.uint8(22).asBigUInt, BigUInt(22))
        XCTAssertEqual(ABI.Field.uint256(BigUInt(22)).asBigUInt, BigUInt(22))
        XCTAssertEqual(ABI.Field.int8(22).asInt, 22)
        XCTAssertEqual(ABI.Field.int8(22).asUInt, nil)
        XCTAssertEqual(ABI.Field.int8(22).asBigInt, BigInt(22))
        XCTAssertEqual(ABI.Field.int256(BigInt(22)).asBigInt, BigInt(22))
        XCTAssertEqual(ABI.Field.bool(true).asBool, true)
        XCTAssertEqual(ABI.Field.address(EthAddress("0x0000000000000000000000000000000000000002")).asEthAddress, EthAddress("0x0000000000000000000000000000000000000002"))
        XCTAssertEqual(ABI.Field.bytes1(hex("0x11")).asData, hex("0x11"))
        XCTAssertEqual(ABI.Field.bytes2(hex("0x1122")).asData, hex("0x1122"))
        XCTAssertEqual(ABI.Field.bytes32(hex("0x0000000000000000000000000000000000000000000000000000000000000064")).asData, hex("0x0000000000000000000000000000000000000000000000000000000000000064"))
        XCTAssertEqual(ABI.Field.bytes(hex("0x0000000000000000000000000000000000000000000000000000000000000064")).asData, hex("0x0000000000000000000000000000000000000000000000000000000000000064"))
        XCTAssertEqual(ABI.Field.array(.string, [.string("hi"), .string("mom")]).asArray?.map { $0.asString }, [String("hi"), String("mom")])
        XCTAssertEqual(ABI.Field.tuple2(.string("hi"), .string("mom")).asArray?.map { $0.asString }, [String("hi"), String("mom")])
    }

    func testEncodeTests() throws {
        for test in getCodingTests().filter({ $0.expectedDecodeError == nil }) {
            XCTAssertEqual(showEncoded(test.input.encoded), showEncoded(test.encoded), test.name + (showHelp(test.input) ?? ""))
        }
    }

    func testDecodeTests() throws {
        for test in getCodingTests() {
            if let expectedDecodeError = test.expectedDecodeError {
                do {
                    _ = try test.input.fieldType.decode(test.encoded)
                    XCTFail("\(test.name): Expected error \(expectedDecodeError.localizedDescription), none received")
                } catch let error as ABI.DecodeError {
                    XCTAssertEqual(error.localizedDescription, expectedDecodeError.localizedDescription, test.name)
                }
            } else {
                do {
                    let res = try test.input.fieldType.decode(test.encoded)
                    XCTAssertEqual(res, test.input, test.name)
                } catch let error as ABI.DecodeError {
                    XCTFail("\(test.name): Unexpected error \(error.localizedDescription)")
                }
            }
        }
    }

    func testFunctionEncodeTests() throws {
        for test in functionTests {
            XCTAssertEqual(try showEncoded(test.function.encoded(with: test.fields)), showEncoded(test.encoded), test.name)
        }
    }
}
