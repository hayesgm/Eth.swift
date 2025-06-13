@testable import Eth
import SwiftNumber
import XCTest

func unwrapError<T: Error, U>(_ expression: @autoclosure () throws -> U, as expectedErrorType: T.Type) -> T? {
    do {
        _ = try expression()
        XCTFail("Expected error of type \(expectedErrorType) but no error was thrown")
        return nil
    } catch let error as T {
        return error
    } catch {
        XCTFail("Expected error of type \(expectedErrorType) but got different error: \(error)")
        return nil
    }
}

func unwrapErrorAsync<T: Error, U>(_ expression: @autoclosure () async throws -> U, as expectedErrorType: T.Type) async throws -> T {
    do {
        _ = try await expression()
        throw XCTestError(.failureWhileWaiting, userInfo: ["message": "Expected error of type \(expectedErrorType) but no error was thrown"])
    } catch let error as T {
        return error
    } catch {
        throw XCTestError(.failureWhileWaiting, userInfo: ["message": "Expected error of type \(expectedErrorType) but got different error: \(error)"])
    }
}

private func word(_ x: Int) -> EthWord {
    guard let ethWord = EthWord(fromSNumber: SNumber(x)) else {
        fatalError("Invalid word in EVMTest \(x)")
    }
    return ethWord
}

private func hexes(_ items: [Any]) -> Hex {
    return Hex(items.map { v in
        if let v = v as? Int {
            return word(v).data
        } else if let v = v as? String {
            if let hex = Hex(hex: v) {
                return hex.data
            } else {
                if let enc = v.data(using: .utf8) {
                    return enc + Data(repeating: 0, count: 32 - enc.count)
                } else {
                    fatalError("Failed to encode string to data: \(v)")
                }
            }
        } else if let v = v as? Hex {
            return v.data + Data(repeating: 0, count: 32 - v.count)
        } else if let v = v as? Data {
            return v + Data(repeating: 0, count: 32 - v.count)
        } else if let v = v as? EthWord {
            return v.data
        } else {
            fatalError("Unknown hexes value: \(v)")
        }
    }.reduce(Data()) { $0 + $1 })
}

struct CodingTest {
    let name: String
    let input: ABI.Value
    let encoded: Hex
    let expectedDecodeError: ABI.DecodeError?
    let only: Bool

    init(name: String, input: ABI.Value, encoded: Hex, only: Bool = false) {
        self.name = name
        self.input = input
        self.encoded = encoded
        expectedDecodeError = nil
        self.only = only
    }

    init(input: ABI.Value, encoded: Hex, only: Bool = false) {
        name = input.description
        self.input = input
        self.encoded = encoded
        expectedDecodeError = nil
        self.only = only
    }

    init(name _: String, input: ABI.Value, encoded: Hex, expError expectedDecodeError: ABI.DecodeError, only: Bool = false) {
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
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000037"
        ),
        CodingTest(
            name: "Unsigned Integer Overflow",
            input: .uint8(0x137),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000137",
            expError: ABI.DecodeError.sizedUnsignedIntegerOverflow(8, "0x0000000000000000000000000000000000000000000000000000000000000137")
        ),

        CodingTest(
            input: .int8(0x37),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000037"
        ),
        CodingTest(
            input: .int8(-0x02),
            encoded: "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe"
        ),
        CodingTest(
            input: .int16(-257),
            encoded: "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeff"
        ),
        CodingTest(
            name: "Signed Integer Overflow Negative",
            input: .int8(-257),
            encoded: "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeff",
            expError: ABI.DecodeError.sizedSignedIntegerOverflow(8, "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeff")
        ),
        CodingTest(
            name: "Signed Integer Overflow Positive",
            input: .int8(0x137),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000137",
            expError: ABI.DecodeError.sizedSignedIntegerOverflow(8, "0x0000000000000000000000000000000000000000000000000000000000000137")
        ),
        CodingTest(
            name: "Too Little data",
            input: .uint8(0x37),
            encoded: "0x1122",
            expError: ABI.DecodeError.insufficientData(.uint8, "0x1122")
        ),
        CodingTest(
            name: "Too Much data",
            input: .uint8(0x37),
            encoded: hexes([word(1), word(2)]),
            expError: ABI.DecodeError.excessData(.uint8, "0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002")
        ),
        CodingTest(
            input: .string("hello"),
            encoded: "0x000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000"
        ),
        CodingTest(
            name: "String minor overflow",
            input: .string("hello"),
            encoded: "0x000000000000000000000000000000000000000000000000000000000000003368656c6c6f000000000000000000000000000000000000000000000000000000",
            expError: ABI.DecodeError.insufficientData(.string, "0x68656c6c6f000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "String mega overflow",
            input: .string("hello"),
            encoded: "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff68656c6c6f000000000000000000000000000000000000000000000000000000",
            expError: ABI.DecodeError.integerOverflow(.string, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        ),
        CodingTest(
            name: "String no data",
            input: .string("hello"),
            encoded: "",
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.insufficientData(.string, "")
        ),
        CodingTest(
            name: "String too few words",
            input: .string("hello"),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000005",
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.insufficientData(.string, "")
        ),
        CodingTest(
            name: "String too much data",
            input: .string("hello"),
            encoded: "0x000000000000000000000000000000000000000000000000000000000000000568656c6c6f00000000000000000000000000000000000000000000000000000011",
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.excessData(.string, "0x68656c6c6f00000000000000000000000000000000000000000000000000000011")
        ),
        CodingTest(
            name: "String length too big",
            input: .string("hello"),
            encoded: "0xff00000000000000000000000000000000000000000000000000000000000000",
            // TODO: Improve this error a bit?
            expError: ABI.DecodeError.integerOverflow(.string, "0xff00000000000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "Static Tuple",
            input: .tuple2(.uint8(0x37), .uint8(0x38)),
            encoded: "0x00000000000000000000000000000000000000000000000000000000000000370000000000000000000000000000000000000000000000000000000000000038"
        ),
        CodingTest(
            name: "Dynamic Tuple",
            input: .tuple2(.uint8(0x55), .string("hello")),
            encoded: hexes([0x55, 0x40, /* Heap (0x40) */ 0x05, "hello"])
        ),
        CodingTest(
            name: "Bytes",
            input: .bytes("0x5566"),
            encoded: hexes([0x02, Hex("0x5566")])
        ),
        CodingTest(
            name: "Bytes (2 Words)",
            input: .bytes("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff112233"),
            encoded: hexes([0x23, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", Hex("0x112233")])
        ),
        CodingTest(
            name: "Tuple(Bytes)",
            input: .tuple1(.bytes("0x5566")),
            encoded: hexes([0x20, /* Heap (0x20) */ 0x02, Hex("0x5566")])
        ),
        CodingTest(
            name: "Bytes - Mega Overflow",
            input: .bytes("0xff"),
            encoded: "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff68656c6c6f000000000000000000000000000000000000000000000000000000",
            expError: ABI.DecodeError.integerOverflow(.bytes, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        ),
        CodingTest(
            name: "Tuple(Bytes) - minor overflow",
            input: .tuple1(.bytes(.empty)),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003368656c6c6f000000000000000000000000000000000000000000000000000000",
            expError: ABI.DecodeError.insufficientData(.bytes, "0x68656c6c6f000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "Tuple(Bytes) mega overflow",
            input: .tuple1(.bytes(.empty)),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000020ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff68656c6c6f000000000000000000000000000000000000000000000000000000",
            expError: ABI.DecodeError.integerOverflow(.bytes, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        ),
        CodingTest(
            name: "Bytes1",
            input: .bytes1("0x55"),
            encoded: "0x5500000000000000000000000000000000000000000000000000000000000000"
        ),
        CodingTest(
            name: "Overflow Bytes1",
            input: .bytes1("0x55"),
            encoded: "0x55FF000000000000000000000000000000000000000000000000000000000000",
            expError: ABI.DecodeError.nonEmptyDataFound(.bytes1, "0x55FF000000000000000000000000000000000000000000000000000000000000")
        ),
        CodingTest(
            name: "Bytes2",
            input: .bytes2("0x55DD"),
            encoded: "0x55DD000000000000000000000000000000000000000000000000000000000000"
        ),
        CodingTest(
            input: .bytes32("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"),
            encoded: "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
        ),
        CodingTest(
            name: "Bool True",
            input: .bool(true),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000001"
        ),
        CodingTest(
            name: "Bool False",
            input: .bool(false),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000000"
        ),
        CodingTest(
            name: "Bool Overflow",
            input: .bool(true),
            encoded: "0x0000000000000000000000000000000000000000000000000000000000000002",
            expError: ABI.DecodeError.sizedUnsignedIntegerOverflow(1, "0x0000000000000000000000000000000000000000000000000000000000000002")
        ),
        CodingTest(
            name: "Address",
            input: .address(EthAddress("0x1000000000000000000000000000000000000002")),
            encoded: "0x0000000000000000000000001000000000000000000000000000000000000002"
        ),
        CodingTest(
            name: "Address Non-Empty Data",
            input: .address(EthAddress("0x1000000000000000000000000000000000000002")),
            encoded: "0x1100000000000000000000001000000000000000000000000000000000000002",
            expError: ABI.DecodeError.nonEmptyDataFound(.address, "0x1100000000000000000000001000000000000000000000000000000000000002")
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
            expError: ABI.DecodeError.insufficientData(.uint8, "0x000000000000000000000000000000000000000000000000000000000000")
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
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x100, "0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000568656c6c6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007676f6f6462796500000000000000000000000000000000000000000000000000")
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
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x20, "0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000568656c6c6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007676f6f6462796500000000000000000000000000000000000000000000000000")
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
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x40, "0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000")
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
            expError: ABI.DecodeError.invalidDataHeapPointer(.string, 0x40, 0x81, "0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000081000000000000000000000000000000000000000000000000000000000000000568656c6c6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007676f6f6462796500000000000000000000000000000000000000000000000000")
        ),
    ]

func showEncoded(_ encoded: Hex) -> String {
    "ABI Encoded ⬇️\n\n\t\t\(EthUtil.showChunkedWords(encoded.data))\n\n"
}

func showHelp(_ value: ABI.Value) -> String? {
    switch value {
    case let .tupleN(values):
        let schemaStrings = values.map { $0.schema.description }.joined(separator: ", ")
        let valueValueStrings = values.map { $0.jsonValue }.joined(separator: " ")
        return " - Compare to `cast abi-encode 'tuple(\(schemaStrings))' \(valueValueStrings)`"
    case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10:
        return showHelp(value.asTupleN!)
    default:
        return nil
    }
}

struct FunctionTest {
    let name: String
    let function: ABI.Function
    let values: [ABI.Value]
    let encoded: Hex
    let expectedFunctionError: ABI.FunctionError?
    let expectedDecodeError: ABI.DecodeError?

    init(name: String, function: ABI.Function, values: [ABI.Value], encoded: Hex) {
        self.name = name
        self.function = function
        self.values = values
        self.encoded = encoded
        expectedFunctionError = nil
        expectedDecodeError = nil
    }

    init(function: ABI.Function, values: [ABI.Value], encoded: Hex) {
        name = function.signature
        self.function = function
        self.values = values
        self.encoded = encoded
        expectedFunctionError = nil
        expectedDecodeError = nil
    }

    // init(input: ABI.Value, encoded: Hex) {
    //     name = input.description
    //     self.input = input
    //     self.encoded = encoded
    //     expectedDecodeError = nil
    // }

    // init(name _: String, input: ABI.Value, encoded: Hex, expError expectedDecodeError: ABI.DecodeError) {
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
        values: [.uint8(0x37)],
        encoded: "0xa8cb34810000000000000000000000000000000000000000000000000000000000000037"
    ),
    FunctionTest(
        function: ABI.Function(
            name: "cool",
            inputs: [.uint8, .tuple([.uint8, .string, .uint8])],
            outputs: []
        ),
        values: [.uint8(19), .tuple3(.uint8(22), .string("hello"), .uint8(33))],
        encoded: "0xcd4d69f600000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000001600000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000021000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000"
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

        XCTAssertEqual(ABI.Value.string(invalidString!).encoded.hex, "0x0000000000000000000000000000000000000000000000000000000000000003c383280000000000000000000000000000000000000000000000000000000000")
    }

    func testSmallUIntClamped() throws {
        XCTAssertEqual(ABI.Value.uint8(300).encoded.hex, "0x00000000000000000000000000000000000000000000000000000000000000ff")
        XCTAssertEqual(ABI.Value.uint16(0x10000).encoded.hex, "0x000000000000000000000000000000000000000000000000000000000000ffff")
        XCTAssertEqual(ABI.Value.uint24(0x1000000).encoded.hex, "0x0000000000000000000000000000000000000000000000000000000000ffffff")
        XCTAssertEqual(ABI.Value.uint32(0x1_0000_0000).encoded.hex, "0x00000000000000000000000000000000000000000000000000000000ffffffff")
    }

    func testLargeUIntClamped() throws {
        XCTAssertEqual(ABI.Value.uint40(Number(1) << 39).encoded.hex, "0x0000000000000000000000000000000000000000000000000000008000000000")
        XCTAssertEqual(ABI.Value.uint40(Number(1) << 41).encoded.hex, "0x000000000000000000000000000000000000000000000000000000ffffffffff")
        XCTAssertEqual(ABI.Value.uint256(Number(1) << 257).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
    }

    func testSmallIntClamped() throws {
        XCTAssertEqual(ABI.Value.int8(100).encoded.hex, "0x0000000000000000000000000000000000000000000000000000000000000064")
        XCTAssertEqual(ABI.Value.int8(200).encoded.hex, "0x000000000000000000000000000000000000000000000000000000000000007f")
        XCTAssertEqual(ABI.Value.int8(-200).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff80")
        XCTAssertEqual(ABI.Value.int16(99999).encoded.hex, "0x0000000000000000000000000000000000000000000000000000000000007fff")
        XCTAssertEqual(ABI.Value.int16(-99999).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8000")
        XCTAssertEqual(ABI.Value.int24(0x1000000).encoded.hex, "0x00000000000000000000000000000000000000000000000000000000007fffff")
        XCTAssertEqual(ABI.Value.int24(-0x1000000).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffff800000")
        XCTAssertEqual(ABI.Value.int32(0x1_0000_0000).encoded.hex, "0x000000000000000000000000000000000000000000000000000000007fffffff")
        XCTAssertEqual(ABI.Value.int32(-0x1_0000_0000).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff80000000")
    }

    func testLargeIntClamped() throws {
        XCTAssertEqual(ABI.Value.int40(SNumber(1) << 38).encoded.hex, "0x0000000000000000000000000000000000000000000000000000004000000000")
        XCTAssertEqual(ABI.Value.int40(-(SNumber(1) << 38)).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffc000000000")
        XCTAssertEqual(ABI.Value.int40(SNumber(1) << 41).encoded.hex, "0x0000000000000000000000000000000000000000000000000000007fffffffff")
        XCTAssertEqual(ABI.Value.int40(-(SNumber(1) << 41)).encoded.hex, "0xffffffffffffffffffffffffffffffffffffffffffffffffffffff8000000000")
        XCTAssertEqual(ABI.Value.int256(SNumber(1) << 257).encoded.hex, "0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        XCTAssertEqual(ABI.Value.int256(-(SNumber(1) << 257)).encoded.hex, "0x8000000000000000000000000000000000000000000000000000000000000000")
    }

    func testUnwrappingFunctions() throws {
        XCTAssertEqual(ABI.Value.string("hello").asString, "hello")
        XCTAssertEqual(ABI.Value.uint8(22).asString, nil)
        XCTAssertEqual(ABI.Value.uint8(22).asUInt, 22)
        XCTAssertEqual(ABI.Value.uint8(22).asInt, nil)
        XCTAssertEqual(ABI.Value.uint8(22).asSNumber, nil)
        XCTAssertEqual(ABI.Value.uint8(22).asNumber, Number(22))
        XCTAssertEqual(ABI.Value.uint256(Number(22)).asNumber, Number(22))
        XCTAssertEqual(ABI.Value.int8(22).asInt, 22)
        XCTAssertEqual(ABI.Value.int8(22).asUInt, nil)
        XCTAssertEqual(ABI.Value.int8(22).asSNumber, SNumber(22))
        XCTAssertEqual(ABI.Value.int256(SNumber(22)).asSNumber, SNumber(22))
        XCTAssertEqual(ABI.Value.bool(true).asBool, true)
        XCTAssertEqual(ABI.Value.address(EthAddress("0x0000000000000000000000000000000000000002")).asEthAddress, EthAddress("0x0000000000000000000000000000000000000002"))
        XCTAssertEqual(ABI.Value.bytes1("0x11").asHex, "0x11")
        XCTAssertEqual(ABI.Value.bytes2("0x1122").asHex, "0x1122")
        XCTAssertEqual(ABI.Value.bytes32("0x0000000000000000000000000000000000000000000000000000000000000064").asHex, "0x0000000000000000000000000000000000000000000000000000000000000064")
        XCTAssertEqual(ABI.Value.bytes("0x0000000000000000000000000000000000000000000000000000000000000064").asHex, "0x0000000000000000000000000000000000000000000000000000000000000064")
        XCTAssertEqual(ABI.Value.array(.string, [.string("hi"), .string("mom")]).asArray?.map { $0.asString }, [String("hi"), String("mom")])
        XCTAssertEqual(ABI.Value.tuple2(.string("hi"), .string("mom")).asArray?.map { $0.asString }, [String("hi"), String("mom")])
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
                    _ = try test.input.schema.decode(test.encoded)
                    XCTFail("\(test.name): Expected error \(expectedDecodeError.localizedDescription), none received")
                } catch let error as ABI.DecodeError {
                    XCTAssertEqual(error.localizedDescription, expectedDecodeError.localizedDescription, test.name)
                }
            } else {
                do {
                    let res = try test.input.schema.decode(test.encoded)
                    XCTAssertEqual(res, test.input, test.name)
                } catch let error as ABI.DecodeError {
                    XCTFail("\(test.name): Unexpected error \(error.localizedDescription)")
                }
            }
        }
    }

    func testFunctionEncodeTests() throws {
        for test in functionTests {
            XCTAssertEqual(try showEncoded(test.function.encoded(with: test.values)), showEncoded(test.encoded), test.name)
        }
    }

    func testFunctionExamples() throws {
        XCTAssertEqual(
            try ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.uint8(22)]),
            Hex("0xa8cb34810000000000000000000000000000000000000000000000000000000000000016")
        )

        XCTAssertEqual(
            try ABI.Function(name: "cool", inputs: [], outputs: [.uint8]).decode(output: "0000000000000000000000000000000000000000000000000000000000000016"),
            ABI.Value.tuple1(.uint8(22))
        )

        XCTAssertEqual(
            try ABI.Function(name: "myError", inputs: [.uint8]).decodeInput(input: Hex("0x10ff10dd0000000000000000000000000000000000000000000000000000000000000016")),
            .tuple1(.uint8(22))
        )

        XCTAssertEqual(
            ABI.Function(name: "cool", inputs: [.uint8], outputs: []).inputTuple,
            .tuple([.uint8])
        )

        XCTAssertEqual(
            ABI.Function(name: "cool", inputs: [.uint8], outputs: []).outputTuple,
            .tuple([])
        )

        XCTAssertEqual(
            ABI.Function(name: "cool", inputs: [.uint8], outputs: []).signature,
            "cool(uint8)"
        )

        XCTAssertEqual(
            ABI.Function(name: "cool", inputs: [.uint8], outputs: []).description,
            "cool(uint8)"
        )

        XCTAssertEqual(
            ABI.Function(name: "cool", inputs: [.uint8], outputs: []).signatureHash,
            Hex("0xa8cb3481")
        )

        XCTAssertEqual(
            try ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.uint8(22)]),
            Hex("0xa8cb34810000000000000000000000000000000000000000000000000000000000000016")
        )

        XCTAssertEqual(
            try unwrapError(ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.string("hello")]), as: ABI.FunctionError.self),
            ABI.FunctionError.invalidFunctionInput(.tuple([.uint8]), .tuple([.string]))
        )

        XCTAssertEqual(
            try ABI.Function(name: "cool", inputs: [.uint8], outputs: []).decodeInput(input: "0xa8cb34810000000000000000000000000000000000000000000000000000000000000016"),
            .tuple1(.uint8(22))
        )

        XCTAssertEqual(
            try ABI.Function(name: "cool", inputs: [.uint8], outputs: []).decodeInput(input: "0x0000000000000000000000000000000000000000000000000000000000000016", signatureIncluded: false),
            .tuple1(.uint8(22))
        )

        XCTAssertEqual(
            try unwrapError(ABI.Function(name: "cool", inputs: [.uint8], outputs: []).decodeInput(input: "0xffffffff0000000000000000000000000000000000000000000000000000000000000016"), as: ABI.FunctionError.self),
            ABI.FunctionError.mismatchedAbiSignature("0xa8cb3481", "0xffffffff")
        )

        XCTAssertEqual(
            try unwrapError(ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.string("hello")]), as: ABI.FunctionError.self),
            ABI.FunctionError.invalidFunctionInput(.tuple([.uint8]), .tuple([.string]))
        )

        XCTAssertEqual(
            try ABI.Function(name: "cool", inputs: [], outputs: [.uint8]).decode(output: "0x0000000000000000000000000000000000000000000000000000000000000016"),
            .tuple1(.uint8(0x16))
        )

        XCTAssertEqual(
            try unwrapError(ABI.Function(name: "cool", inputs: [], outputs: [.uint8]).decode(output: "0x1122"), as: ABI.DecodeError.self),
            ABI.DecodeError.insufficientData(.uint8, "0x1122")
        )
    }
}
