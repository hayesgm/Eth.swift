import Foundation
import SwiftNumber

public extension ABI {
    /**
     * A `Value` represents any value that can be converted to or from an Ethereum ABI-encoded value.
     *
     * Example Values:
     * ```
     * ABI.Value.uint256(Number(0x55))
     * ABI.Value.uint8(55)
     * ABI.Value.string("hi")
     * ABI.Value.array(.string, [.string("hello"), .string("world")])
     * ABI.Value.tuple2(.bool(true), .string("false"))
     * ```
     *
     * Values can be encoded with the `.encoded` computed property
     *
     * ```
     * > ABI.Value.uint256(Number(0x55)).encoded
     * Hex("0x0000000000000000000000000000000000000000000000000000000000000055")
     * ```
     *
     * You can also decode from `Hex` to a `Value`, e.g.
     *
     * ```
     * > ABI.Schema.uint256.decode("0x0000000000000000000000000000000000000000000000000000000000000055")
     * ABI.Value.uint256(Number(0x55))
     * ```
     *
     * Canonically, to decode a complex tuple, you can pattern match on the the decoded `Value`.
     *
     * ```
     * switch ABI.Schema.tuple([.bool, .string]).decode(Hex("0x...")) {
     *   case .tuple2(.bool(isCool), .string(name)):
     *      print("\(name) \(isCool ? "is cool" : "is not cool")")
     *   default:
     *      throw ABI.DecodeError.invalidResponse // should be impossible, but cases must be exhaustive
     * }
     * ```
     *
     * Notes:
     *   - Small integers (≤32 bits) are represented as `UInt` or `Int` values. Larger values are represented as `Number` or `SNumber`.
     *   - Tuples are canonically represented for easy pattern-matching, e.g., `.tuple2(.uint256, .uint256)`. For tuples with more than 16 values, use `.tupleN([.uint256, ...])`.
     */
    enum Value: Equatable, CustomStringConvertible, Sendable {
        // Unsigned Int
        case uint8(UInt)
        case uint16(UInt)
        case uint24(UInt)
        case uint32(UInt)
        case uint40(Number)
        case uint48(Number)
        case uint56(Number)
        case uint64(Number)
        case uint72(Number)
        case uint80(Number)
        case uint88(Number)
        case uint96(Number)
        case uint104(Number)
        case uint112(Number)
        case uint120(Number)
        case uint128(Number)
        case uint136(Number)
        case uint144(Number)
        case uint152(Number)
        case uint160(Number)
        case uint168(Number)
        case uint176(Number)
        case uint184(Number)
        case uint192(Number)
        case uint200(Number)
        case uint208(Number)
        case uint216(Number)
        case uint224(Number)
        case uint232(Number)
        case uint240(Number)
        case uint248(Number)
        case uint256(Number)

        // Signed Int
        case int8(Int)
        case int16(Int)
        case int24(Int)
        case int32(Int)
        case int40(SNumber)
        case int48(SNumber)
        case int56(SNumber)
        case int64(SNumber)
        case int72(SNumber)
        case int80(SNumber)
        case int88(SNumber)
        case int96(SNumber)
        case int104(SNumber)
        case int112(SNumber)
        case int120(SNumber)
        case int128(SNumber)
        case int136(SNumber)
        case int144(SNumber)
        case int152(SNumber)
        case int160(SNumber)
        case int168(SNumber)
        case int176(SNumber)
        case int184(SNumber)
        case int192(SNumber)
        case int200(SNumber)
        case int208(SNumber)
        case int216(SNumber)
        case int224(SNumber)
        case int232(SNumber)
        case int240(SNumber)
        case int248(SNumber)
        case int256(SNumber)

        // Bool
        case bool(Bool)

        // Address
        case address(EthAddress)

        // Dynamic Bytes
        case bytes(Hex)

        case bytes1(Hex)
        case bytes2(Hex)
        case bytes3(Hex)
        case bytes4(Hex)
        case bytes5(Hex)
        case bytes6(Hex)
        case bytes7(Hex)
        case bytes8(Hex)
        case bytes9(Hex)
        case bytes10(Hex)
        case bytes11(Hex)
        case bytes12(Hex)
        case bytes13(Hex)
        case bytes14(Hex)
        case bytes15(Hex)
        case bytes16(Hex)
        case bytes17(Hex)
        case bytes18(Hex)
        case bytes19(Hex)
        case bytes20(Hex)
        case bytes21(Hex)
        case bytes22(Hex)
        case bytes23(Hex)
        case bytes24(Hex)
        case bytes25(Hex)
        case bytes26(Hex)
        case bytes27(Hex)
        case bytes28(Hex)
        case bytes29(Hex)
        case bytes30(Hex)
        case bytes31(Hex)
        case bytes32(Hex)

        // String
        case string(String)

        // Arrays
        case arrayN(Schema, Int, [Value])
        case array(Schema, [Value])

        // Tuples
        case tuple0
        indirect case tuple1(Value)
        indirect case tuple2(Value, Value)
        indirect case tuple3(Value, Value, Value)
        indirect case tuple4(Value, Value, Value, Value)
        indirect case tuple5(Value, Value, Value, Value, Value)
        indirect case tuple6(Value, Value, Value, Value, Value, Value)
        indirect case tuple7(Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple8(Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple9(Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple10(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple11(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple12(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple13(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple14(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple15(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple16(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple17(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple18(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple19(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple20(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple21(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple22(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple23(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple24(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple25(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple26(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple27(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple28(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple29(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple30(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple31(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple32(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple33(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple34(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple35(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple36(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple37(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple38(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple39(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple40(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple41(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple42(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple43(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple44(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple45(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple46(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple47(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple48(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple49(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tuple50(Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value, Value)
        indirect case tupleN([Value])

        /// Returns a `String` if ``Value` contains a `.string`, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.string("hello").asString
        /// "hello"
        /// ```
        public var asString: String? {
            switch self {
            case let .string(x):
                x
            default:
                nil
            }
        }

        /// Returns an `Int` if `Value` contains a 32-byte or smaller signed `.int`, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.int8(-22).asInt
        /// -22
        ///
        /// > ABI.Value.int256(SNumber(-22)).asInt
        /// nil
        /// ```
        public var asInt: Int? {
            switch self {
            case let .int8(x), let .int16(x), let .int24(x), let .int32(x):
                x
            default:
                nil
            }
        }

        /// Returns a `UInt` if `Value` contains a 32-byte or smaller `.uint`, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.uint8(22).asUInt
        /// 22
        ///
        /// > ABI.Value.uint256(Number(22)).asUInt
        /// nil
        /// ```
        public var asUInt: UInt? {
            switch self {
            case let .uint8(x), let .uint16(x), let .uint24(x), let .uint32(x):
                x
            default:
                nil
            }
        }

        /// Returns a `Number` if `Value` contains any `.uint` value, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.uint8(22).asNumber
        /// Number(22)
        ///
        /// > ABI.Value.uint256(Number(22)).asNumber
        /// Number(22)
        /// ```
        public var asNumber: Number? {
            switch self {
            case let .uint40(x), let .uint48(x), let .uint56(x), let .uint64(x),
                 let .uint72(x), let .uint80(x), let .uint88(x), let .uint96(x),
                 let .uint104(x), let .uint112(x), let .uint120(x), let .uint128(x),
                 let .uint136(x), let .uint144(x), let .uint152(x), let .uint160(x),
                 let .uint168(x), let .uint176(x), let .uint184(x), let .uint192(x),
                 let .uint200(x), let .uint208(x), let .uint216(x), let .uint224(x),
                 let .uint232(x), let .uint240(x), let .uint248(x), let .uint256(x):
                x
            case let .uint8(x), let .uint16(x), let .uint24(x), let .uint32(x):
                Number(x)
            default:
                nil
            }
        }

        /// Returns a `SNumber` if `Value` contains any signed `.int` value, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.int8(-22).asSNumber
        /// SNumber(-22)
        ///
        /// > ABI.Value.int256(SNumber(-22)).asSNumber
        /// SNumber(-22)
        /// ```
        public var asSNumber: SNumber? {
            switch self {
            case let .int40(x), let .int48(x), let .int56(x), let .int64(x),
                 let .int72(x), let .int80(x), let .int88(x), let .int96(x),
                 let .int104(x), let .int112(x), let .int120(x), let .int128(x),
                 let .int136(x), let .int144(x), let .int152(x), let .int160(x),
                 let .int168(x), let .int176(x), let .int184(x), let .int192(x),
                 let .int200(x), let .int208(x), let .int216(x), let .int224(x),
                 let .int232(x), let .int240(x), let .int248(x), let .int256(x):
                x
            case let .int8(x), let .int16(x), let .int24(x), let .int32(x):
                SNumber(x)
            default:
                nil
            }
        }

        /// Returns a `Bool` if `Value` contains a `.bool`, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.bool(true).asBool
        /// true
        /// ```
        public var asBool: Bool? {
            switch self {
            case let .bool(x):
                x
            default:
                nil
            }
        }

        /// Returns an `EthAddress` if `Value` contains a `.address`, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.address(EthAddress(Hex("0x112233445566778899aa112233445566778899aa"))!).asEthAddress
        /// EthAddress(Hex("0x112233445566778899aa112233445566778899aa"))
        /// ```
        public var asEthAddress: EthAddress? {
            switch self {
            case let .address(x):
                x
            default:
                nil
            }
        }

        /// Returns a `Hex` if `Value` contains a fixed `.bytes0`, `.bytes1`, ..., or variable-sized `.bytes`, otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.bytes1(Hex("0x11")).asHex
        /// Hex("0x11")
        ///
        /// > ABI.Value.bytes(Hex("0x1122")).asHex
        /// Hex("0x1122")
        /// ```
        public var asHex: Hex? {
            switch self {
            case let .bytes(x):
                x
            case let .bytes1(x), let .bytes2(x), let .bytes3(x), let .bytes4(x), let .bytes5(x),
                 let .bytes6(x), let .bytes7(x), let .bytes8(x), let .bytes9(x), let .bytes10(x),
                 let .bytes11(x), let .bytes12(x), let .bytes13(x), let .bytes14(x), let .bytes15(x),
                 let .bytes16(x), let .bytes17(x), let .bytes18(x), let .bytes19(x), let .bytes20(x),
                 let .bytes21(x), let .bytes22(x), let .bytes23(x), let .bytes24(x), let .bytes25(x),
                 let .bytes26(x), let .bytes27(x), let .bytes28(x), let .bytes29(x), let .bytes30(x),
                 let .bytes31(x), let .bytes32(x):
                x
            default:
                nil
            }
        }

        /// Returns an `Array` if `Value` contains a fixed or variable-sized array (`.arrayN` or `.array`) or any tuple (`.tuple0`, ..., `.tupleN`), otherwise `nil`
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.array(.string, [.string("hello"), .string("world")]).asArray
        /// [.string("hello"), .string("world")]
        ///
        /// > ABI.Value.array(.string, [.string("hello"), .string("world")]).asArray?.map { $0.asString }
        /// ["hello", "world"]
        ///
        /// > ABI.Value.tuple2(.int8(22), .string("ok")).asArray
        /// [.uint8(22), .string("ok")]
        /// ```
        public var asArray: [Value]? {
            switch self {
            case let .arrayN(_, _, values):
                values
            case let .array(_, values):
                values
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16, .tuple17, .tuple18, .tuple19, .tuple20, .tuple21, .tuple22, .tuple23, .tuple24, .tuple25, .tuple26, .tuple27, .tuple28, .tuple29, .tuple30, .tuple31, .tuple32, .tuple33, .tuple34, .tuple35, .tuple36, .tuple37, .tuple38, .tuple39, .tuple40, .tuple41, .tuple42, .tuple43, .tuple44, .tuple45, .tuple46, .tuple47, .tuple48, .tuple49, .tuple50, .tupleN:
                tupleValues
            default:
                nil
            }
        }

        /// If the type is a `.tuple0`, `.tuple1`, ... `.tuple24`, returns a `.tupleN`, otherwise `nil`.
        ///
        /// Examples:
        /// ```
        /// > ABI.Value.tuple2(.uint8(22), .string("hello")).asTupleN
        /// .tupleN([.uint8(22), .string("hello")])
        ///
        /// > ABI.Value.tuple0.asTupleN
        /// .tupleN([])
        ///
        /// > ABI.Value.tupleN([.uint8(22), .string("hello")]).asTupleN
        /// .tupleN([.uint8(22), .string("hello")])
        /// ```
        public var asTupleN: Value? {
            if let tupleValues {
                .tupleN(tupleValues)
            } else {
                nil
            }
        }

        /// Returns the associated `ABI.Schema` for this value
        ///
        /// Examples
        /// ```
        /// > ABI.Value.uint256(22).schema
        /// .uint256
        ///
        /// > ABI.Value.tuple2(.uint8(22), .string("hello")).schema
        /// .tuple([.uint8, .string])
        /// ```
        public var schema: Schema {
            switch self {
            case .uint8:
                .uint8
            case .uint16:
                .uint16
            case .uint24:
                .uint24
            case .uint32:
                .uint32
            case .uint40:
                .uint40
            case .uint48:
                .uint48
            case .uint56:
                .uint56
            case .uint64:
                .uint64
            case .uint72:
                .uint72
            case .uint80:
                .uint80
            case .uint88:
                .uint88
            case .uint96:
                .uint96
            case .uint104:
                .uint104
            case .uint112:
                .uint112
            case .uint120:
                .uint120
            case .uint128:
                .uint128
            case .uint136:
                .uint136
            case .uint144:
                .uint144
            case .uint152:
                .uint152
            case .uint160:
                .uint160
            case .uint168:
                .uint168
            case .uint176:
                .uint176
            case .uint184:
                .uint184
            case .uint192:
                .uint192
            case .uint200:
                .uint200
            case .uint208:
                .uint208
            case .uint216:
                .uint216
            case .uint224:
                .uint224
            case .uint232:
                .uint232
            case .uint240:
                .uint240
            case .uint248:
                .uint248
            case .uint256:
                .uint256
            case .int8:
                .int8
            case .int16:
                .int16
            case .int24:
                .int24
            case .int32:
                .int32
            case .int40:
                .int40
            case .int48:
                .int48
            case .int56:
                .int56
            case .int64:
                .int64
            case .int72:
                .int72
            case .int80:
                .int80
            case .int88:
                .int88
            case .int96:
                .int96
            case .int104:
                .int104
            case .int112:
                .int112
            case .int120:
                .int120
            case .int128:
                .int128
            case .int136:
                .int136
            case .int144:
                .int144
            case .int152:
                .int152
            case .int160:
                .int160
            case .int168:
                .int168
            case .int176:
                .int176
            case .int184:
                .int184
            case .int192:
                .int192
            case .int200:
                .int200
            case .int208:
                .int208
            case .int216:
                .int216
            case .int224:
                .int224
            case .int232:
                .int232
            case .int240:
                .int240
            case .int248:
                .int248
            case .int256:
                .int256
            case .bool:
                .bool
            case .address:
                .address
            case .bytes:
                .bytes
            case .bytes1:
                .bytes1
            case .bytes2:
                .bytes2
            case .bytes3:
                .bytes3
            case .bytes4:
                .bytes4
            case .bytes5:
                .bytes5
            case .bytes6:
                .bytes6
            case .bytes7:
                .bytes7
            case .bytes8:
                .bytes8
            case .bytes9:
                .bytes9
            case .bytes10:
                .bytes10
            case .bytes11:
                .bytes11
            case .bytes12:
                .bytes12
            case .bytes13:
                .bytes13
            case .bytes14:
                .bytes14
            case .bytes15:
                .bytes15
            case .bytes16:
                .bytes16
            case .bytes17:
                .bytes17
            case .bytes18:
                .bytes18
            case .bytes19:
                .bytes19
            case .bytes20:
                .bytes20
            case .bytes21:
                .bytes21
            case .bytes22:
                .bytes22
            case .bytes23:
                .bytes23
            case .bytes24:
                .bytes24
            case .bytes25:
                .bytes25
            case .bytes26:
                .bytes26
            case .bytes27:
                .bytes27
            case .bytes28:
                .bytes28
            case .bytes29:
                .bytes29
            case .bytes30:
                .bytes30
            case .bytes31:
                .bytes31
            case .bytes32:
                .bytes32
            case .string:
                .string
            case let .arrayN(schema, n, _):
                .arrayN(schema, n)
            case let .array(schema, _):
                .array(schema)
            case let .tupleN(values):
                .tuple(values.map { $0.schema })
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16, .tuple17, .tuple18, .tuple19, .tuple20, .tuple21, .tuple22, .tuple23, .tuple24, .tuple25, .tuple26, .tuple27, .tuple28, .tuple29, .tuple30, .tuple31, .tuple32, .tuple33, .tuple34, .tuple35, .tuple36, .tuple37, .tuple38, .tuple39, .tuple40, .tuple41, .tuple42, .tuple43, .tuple44, .tuple45, .tuple46, .tuple47, .tuple48, .tuple49, .tuple50:
                asTupleN!.schema
            }
        }

        static func tupleFromValues(_ values: [Value]) -> Value {
            switch values.count {
            case 0:
                return .tuple0
            case 1:
                return .tuple1(values[0])
            case 2:
                return .tuple2(values[0], values[1])
            case 3:
                return .tuple3(values[0], values[1], values[2])
            case 4:
                return .tuple4(values[0], values[1], values[2], values[3])
            case 5:
                return .tuple5(values[0], values[1], values[2], values[3], values[4])
            case 6:
                return .tuple6(values[0], values[1], values[2], values[3], values[4], values[5])
            case 7:
                return .tuple7(values[0], values[1], values[2], values[3], values[4], values[5], values[6])
            case 8:
                return .tuple8(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7])
            case 9:
                return .tuple9(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8])
            case 10:
                return .tuple10(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9])
            case 11:
                return .tuple11(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10])
            case 12:
                return .tuple12(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11])
            case 13:
                return .tuple13(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12])
            case 14:
                return .tuple14(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13])
            case 15:
                return .tuple15(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14])
            case 16:
                return .tuple16(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15])
            case 17:
                return .tuple17(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16])
            case 18:
                return .tuple18(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17])
            case 19:
                return .tuple19(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18])
            case 20:
                return .tuple20(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19])
            case 21:
                return .tuple21(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20])
            case 22:
                return .tuple22(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21])
            case 23:
                return .tuple23(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22])
            case 24:
                return .tuple24(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23])
            case 25:
                return .tuple25(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24])
            case 26:
                return .tuple26(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25])
            case 27:
                return .tuple27(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26])
            case 28:
                return .tuple28(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27])
            case 29:
                return .tuple29(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28])
            case 30:
                return .tuple30(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29])
            case 31:
                return .tuple31(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30])
            case 32:
                return .tuple32(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31])
            case 33:
                return .tuple33(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32])
            case 34:
                return .tuple34(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33])
            case 35:
                return .tuple35(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34])
            case 36:
                return .tuple36(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35])
            case 37:
                return .tuple37(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36])
            case 38:
                return .tuple38(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37])
            case 39:
                return .tuple39(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38])
            case 40:
                return .tuple40(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39])
            case 41:
                return .tuple41(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40])
            case 42:
                return .tuple42(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41])
            case 43:
                return .tuple43(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42])
            case 44:
                return .tuple44(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43])
            case 45:
                return .tuple45(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44])
            case 46:
                return .tuple46(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44], values[45])
            case 47:
                return .tuple47(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44], values[45], values[46])
            case 48:
                return .tuple48(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44], values[45], values[46], values[47])
            case 49:
                return .tuple49(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44], values[45], values[46], values[47], values[48])
            case 50:
                return .tuple50(values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15], values[16], values[17], values[18], values[19], values[20], values[21], values[22], values[23], values[24], values[25], values[26], values[27], values[28], values[29], values[30], values[31], values[32], values[33], values[34], values[35], values[36], values[37], values[38], values[39], values[40], values[41], values[42], values[43], values[44], values[45], values[46], values[47], values[48], values[49])
            default:
                return .tupleN(values)
            }
        }

        private var tupleValues: [Value]? {
            switch self {
            case .tuple0:
                return []
            case let .tuple1(value0):
                return [value0]
            case let .tuple2(value0, value1):
                return [value0, value1]
            case let .tuple3(value0, value1, value2):
                return [value0, value1, value2]
            case let .tuple4(value0, value1, value2, value3):
                return [value0, value1, value2, value3]
            case let .tuple5(value0, value1, value2, value3, value4):
                return [value0, value1, value2, value3, value4]
            case let .tuple6(value0, value1, value2, value3, value4, value5):
                return [value0, value1, value2, value3, value4, value5]
            case let .tuple7(value0, value1, value2, value3, value4, value5, value6):
                return [value0, value1, value2, value3, value4, value5, value6]
            case let .tuple8(value0, value1, value2, value3, value4, value5, value6, value7):
                return [value0, value1, value2, value3, value4, value5, value6, value7]
            case let .tuple9(value0, value1, value2, value3, value4, value5, value6, value7, value8):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8]
            case let .tuple10(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9]
            case let .tuple11(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10]
            case let .tuple12(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11]
            case let .tuple13(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12]
            case let .tuple14(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13]
            case let .tuple15(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14]
            case let .tuple16(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15]
            case let .tuple17(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16]
            case let .tuple18(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17]
            case let .tuple19(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18]
            case let .tuple20(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19]
            case let .tuple21(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20]
            case let .tuple22(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21]
            case let .tuple23(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22]
            case let .tuple24(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23]
            case let .tuple25(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24]
            case let .tuple26(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25]
            case let .tuple27(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26]
            case let .tuple28(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27]
            case let .tuple29(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28]
            case let .tuple30(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29]
            case let .tuple31(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30]
            case let .tuple32(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31]
            case let .tuple33(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32]
            case let .tuple34(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33]
            case let .tuple35(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34]
            case let .tuple36(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35]
            case let .tuple37(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36]
            case let .tuple38(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37]
            case let .tuple39(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38]
            case let .tuple40(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39]
            case let .tuple41(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40]
            case let .tuple42(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41]
            case let .tuple43(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42]
            case let .tuple44(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43]
            case let .tuple45(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44]
            case let .tuple46(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45]
            case let .tuple47(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46]
            case let .tuple48(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46, value47):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46, value47]
            case let .tuple49(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46, value47, value48):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46, value47, value48]
            case let .tuple50(value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46, value47, value48, value49):
                return [value0, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10, value11, value12, value13, value14, value15, value16, value17, value18, value19, value20, value21, value22, value23, value24, value25, value26, value27, value28, value29, value30, value31, value32, value33, value34, value35, value36, value37, value38, value39, value40, value41, value42, value43, value44, value45, value46, value47, value48, value49]
            case let .tupleN(values):
                return values
            default:
                return nil
            }
        }

        private var bits: UInt? {
            switch self {
            case .uint8:
                8
            case .uint16:
                16
            case .uint24:
                24
            case .uint32:
                32
            case .uint40:
                40
            case .uint48:
                48
            case .uint56:
                56
            case .uint64:
                64
            case .uint72:
                72
            case .uint80:
                80
            case .uint88:
                88
            case .uint96:
                96
            case .uint104:
                104
            case .uint112:
                112
            case .uint120:
                120
            case .uint128:
                128
            case .uint136:
                136
            case .uint144:
                144
            case .uint152:
                152
            case .uint160:
                160
            case .uint168:
                168
            case .uint176:
                176
            case .uint184:
                184
            case .uint192:
                192
            case .uint200:
                200
            case .uint208:
                208
            case .uint216:
                216
            case .uint224:
                224
            case .uint232:
                232
            case .uint240:
                240
            case .uint248:
                248
            case .uint256:
                256
            case .int8:
                8
            case .int16:
                16
            case .int24:
                24
            case .int32:
                32
            case .int40:
                40
            case .int48:
                48
            case .int56:
                56
            case .int64:
                64
            case .int72:
                72
            case .int80:
                80
            case .int88:
                88
            case .int96:
                96
            case .int104:
                104
            case .int112:
                112
            case .int120:
                120
            case .int128:
                128
            case .int136:
                136
            case .int144:
                144
            case .int152:
                152
            case .int160:
                160
            case .int168:
                168
            case .int176:
                176
            case .int184:
                184
            case .int192:
                192
            case .int200:
                200
            case .int208:
                208
            case .int216:
                216
            case .int224:
                224
            case .int232:
                232
            case .int240:
                240
            case .int248:
                248
            case .int256:
                256
            default:
                nil
            }
        }

        /**
         * The ABI-encoded `Hex` corresponding to this `Value`
         *
         * Examples:
         * ```
         * > .uint256(Number(0x55)).encoded
         * Hex("0x0000000000000000000000000000000000000000000000000000000000000055")
         *
         * > .tuple2(.uint256(Number(0x55), .bool(true)).encoded
         * Hex("0x00000000000000000000000000000000000000000000000000000000000000550000000000000000000000000000000000000000000000000000000000000001")
         * ```
         *
         * Note: This method never fails, but be aware of the following edge cases:
         *   - Integer values are clamped to their bounds. For example, `.uint8(999)` will be treated as `uint8(255)`.
         *   - String values must be UTF-8 encodable; otherwise, they will be treated as an empty string `""`.
         *
         * See [Solidity ABI Specification](https://docs.soliditylang.org/en/v0.8.26/abi-spec.html) for details.
         *
         * - Returns: An ABI-encoded `Hex` representation of the value.
         */
        public var encoded: Hex {
            switch self {
            case let .uint8(v), let .uint16(v), let .uint24(v), let .uint32(v):
                let bits = self.bits!
                let max: UInt = (1 << bits) - 1
                let clamped = clamped(uint: v, to: 0 ... max)
                return EthWord(fromUInt: clamped)!.hex
            case let .uint40(v), let .uint48(v), let .uint56(v), let .uint64(v), let .uint72(v), let .uint80(v), let .uint88(v), let .uint96(v), let .uint104(v), let .uint112(v), let .uint120(v), let .uint128(v), let .uint136(v), let .uint144(v), let .uint152(v), let .uint160(v), let .uint168(v), let .uint176(v), let .uint184(v), let .uint192(v), let .uint200(v), let .uint208(v), let .uint216(v), let .uint224(v), let .uint232(v), let .uint240(v), let .uint248(v), let .uint256(v):
                let bits = self.bits!
                let max: Number = (Number(1) << bits) - 1
                let clamped = clamped(number: v, to: 0 ... max)
                return EthWord(fromNumber: clamped)!.hex
            case let .int8(v), let .int16(v), let .int24(v), let .int32(v):
                let bits = self.bits!
                let max: Int = (1 << (bits - 1)) - 1
                let min: Int = -(1 << (bits - 1))
                let clamped = clamped(int: v, to: min ... max)
                return EthWord(fromInt: clamped)!.hex
            case let .int40(v), let .int48(v), let .int56(v), let .int64(v), let .int72(v), let .int80(v), let .int88(v), let .int96(v), let .int104(v), let .int112(v), let .int120(v), let .int128(v), let .int136(v), let .int144(v), let .int152(v), let .int160(v), let .int168(v), let .int176(v), let .int184(v), let .int192(v), let .int200(v), let .int208(v), let .int216(v), let .int224(v), let .int232(v), let .int240(v), let .int248(v), let .int256(v):
                let bits = self.bits!
                let max: SNumber = (SNumber(1) << (bits - 1)) - 1
                let min: SNumber = -(SNumber(1) << (bits - 1))
                let clamped = clamped(sNumber: v, to: min ... max)
                return EthWord(fromSNumber: clamped)!.hex
            case let .bool(b):
                // Zero and one are guaranteed to fit in an EthWord, QED
                return EthWord(fromUInt: b ? 1 : 0)!.hex
            case let .address(v):
                // Address is guaranteed to be 20-bytes which fits in an EthWord, QED
                return EthWord(hexExtending: v.address)!.hex
            case let .bytes(d):
                return Hex(encodeVariableSizedData(data: d.data))
            case let .bytes1(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes2(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes3(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes4(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes5(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes6(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes7(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes8(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes9(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes10(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes11(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes12(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes13(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes14(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes15(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes16(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes17(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes18(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes19(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes20(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes21(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes22(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes23(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes24(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes25(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes26(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes27(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes28(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes29(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes30(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes31(v):
                return Hex(padRightToWordBoundary(v))
            case let .bytes32(v):
                return Hex(padRightToWordBoundary(v))
            case let .string(s):
                // If the string isn't valid UTF8, this will return an empty string encoding.
                // Swift doesn't make it easy to generate an invalid UTF-8 string.
                if let string = s.data(using: .utf8) {
                    return Hex(encodeVariableSizedData(data: string))
                } else {
                    return Hex(encodeVariableSizedData(data: Data()))
                }
            case let .arrayN(_, _, values):
                return Value.tupleN(values).encoded
            case let .array(_, values):
                // Arrays simply concat their elements
                let encodedValues = Value.tupleN(values).encoded
                // Note: we'll assert that values.count will always fit nicely into an EthWord
                let size = EthWord(fromInt: values.count)!.data
                return Hex(size + encodedValues.data)
            case let .tupleN(values):
                // For a tuple, we encode non-dynamic types in-place ("prim") and dynamic types in a "heap"
                let primarySizeBytes = values.map { $0.schema.primaryWordSize }.reduce(0) { $0 + $1 } * 0x20
                let (prim, heap) = values.reduce((Data(), Data())) { acc, value in
                    let (prim, heap) = acc
                    if value.schema.dynamic {
                        return (prim + EthWord(fromInt: primarySizeBytes + heap.count)!.data, heap + value.encoded.data)
                    } else {
                        return (prim + value.encoded.data, heap)
                    }
                }
                return Hex(prim + heap)
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16, .tuple17, .tuple18, .tuple19, .tuple20, .tuple21, .tuple22, .tuple23, .tuple24, .tuple25, .tuple26, .tuple27, .tuple28, .tuple29, .tuple30, .tuple31, .tuple32, .tuple33, .tuple34, .tuple35, .tuple36, .tuple37, .tuple38, .tuple39, .tuple40, .tuple41, .tuple42, .tuple43, .tuple44, .tuple45, .tuple46, .tuple47, .tuple48, .tuple49, .tuple50:
                return asTupleN!.encoded
            }
        }

        /// Returns a friendly description of a given value
        ///
        /// Examples
        /// ```
        /// > ABI.Value.uint256(0x55).description
        /// "uint256(85)"
        ///
        /// > ABI.Value.string("hello").description
        /// "string(hello)"
        /// ```
        public var description: String {
            switch self {
            case let .uint8(v):
                "uint8(\(v))"
            case let .uint16(v):
                "uint16(\(v))"
            case let .uint24(v):
                "uint24(\(v))"
            case let .uint32(v):
                "uint32(\(v))"
            case let .uint40(v):
                "uint40(\(v.description))"
            case let .uint48(v):
                "uint48(\(v.description))"
            case let .uint56(v):
                "uint56(\(v.description))"
            case let .uint64(v):
                "uint64(\(v.description))"
            case let .uint72(v):
                "uint72(\(v.description))"
            case let .uint80(v):
                "uint80(\(v.description))"
            case let .uint88(v):
                "uint88(\(v.description))"
            case let .uint96(v):
                "uint96(\(v.description))"
            case let .uint104(v):
                "uint104(\(v.description))"
            case let .uint112(v):
                "uint112(\(v.description))"
            case let .uint120(v):
                "uint120(\(v.description))"
            case let .uint128(v):
                "uint128(\(v.description))"
            case let .uint136(v):
                "uint136(\(v.description))"
            case let .uint144(v):
                "uint144(\(v.description))"
            case let .uint152(v):
                "uint152(\(v.description))"
            case let .uint160(v):
                "uint160(\(v.description))"
            case let .uint168(v):
                "uint168(\(v.description))"
            case let .uint176(v):
                "uint176(\(v.description))"
            case let .uint184(v):
                "uint184(\(v.description))"
            case let .uint192(v):
                "uint192(\(v.description))"
            case let .uint200(v):
                "uint200(\(v.description))"
            case let .uint208(v):
                "uint208(\(v.description))"
            case let .uint216(v):
                "uint216(\(v.description))"
            case let .uint224(v):
                "uint224(\(v.description))"
            case let .uint232(v):
                "uint232(\(v.description))"
            case let .uint240(v):
                "uint240(\(v.description))"
            case let .uint248(v):
                "uint248(\(v.description))"
            case let .uint256(v):
                "uint256(\(v.description))"
            case let .int8(v):
                "int8(\(v))"
            case let .int16(v):
                "int16(\(v))"
            case let .int24(v):
                "int24(\(v))"
            case let .int32(v):
                "int32(\(v))"
            case let .int40(v):
                "int40(\(v.description))"
            case let .int48(v):
                "int48(\(v.description))"
            case let .int56(v):
                "int56(\(v.description))"
            case let .int64(v):
                "int64(\(v.description))"
            case let .int72(v):
                "int72(\(v.description))"
            case let .int80(v):
                "int80(\(v.description))"
            case let .int88(v):
                "int88(\(v.description))"
            case let .int96(v):
                "int96(\(v.description))"
            case let .int104(v):
                "int104(\(v.description))"
            case let .int112(v):
                "int112(\(v.description))"
            case let .int120(v):
                "int120(\(v.description))"
            case let .int128(v):
                "int128(\(v.description))"
            case let .int136(v):
                "int136(\(v.description))"
            case let .int144(v):
                "int144(\(v.description))"
            case let .int152(v):
                "int152(\(v.description))"
            case let .int160(v):
                "int160(\(v.description))"
            case let .int168(v):
                "int168(\(v.description))"
            case let .int176(v):
                "int176(\(v.description))"
            case let .int184(v):
                "int184(\(v.description))"
            case let .int192(v):
                "int192(\(v.description))"
            case let .int200(v):
                "int200(\(v.description))"
            case let .int208(v):
                "int208(\(v.description))"
            case let .int216(v):
                "int216(\(v.description))"
            case let .int224(v):
                "int224(\(v.description))"
            case let .int232(v):
                "int232(\(v.description))"
            case let .int240(v):
                "int240(\(v.description))"
            case let .int248(v):
                "int248(\(v.description))"
            case let .int256(v):
                "int256(\(v.description))"
            case let .bool(v):
                "bool(\(v.description))"
            case let .address(v):
                "address(\(v.address)))"
            case let .bytes(d):
                "bytes(\(d))"
            case let .bytes1(v):
                "bytes1(\(v))"
            case let .bytes2(v):
                "bytes2(\(v))"
            case let .bytes3(v):
                "bytes3(\(v))"
            case let .bytes4(v):
                "bytes4(\(v))"
            case let .bytes5(v):
                "bytes5(\(v))"
            case let .bytes6(v):
                "bytes6(\(v))"
            case let .bytes7(v):
                "bytes7(\(v))"
            case let .bytes8(v):
                "bytes8(\(v))"
            case let .bytes9(v):
                "bytes9(\(v))"
            case let .bytes10(v):
                "bytes10(\(v))"
            case let .bytes11(v):
                "bytes11(\(v))"
            case let .bytes12(v):
                "bytes12(\(v))"
            case let .bytes13(v):
                "bytes13(\(v))"
            case let .bytes14(v):
                "bytes14(\(v))"
            case let .bytes15(v):
                "bytes15(\(v))"
            case let .bytes16(v):
                "bytes16(\(v))"
            case let .bytes17(v):
                "bytes17(\(v))"
            case let .bytes18(v):
                "bytes18(\(v))"
            case let .bytes19(v):
                "bytes19(\(v))"
            case let .bytes20(v):
                "bytes20(\(v))"
            case let .bytes21(v):
                "bytes21(\(v))"
            case let .bytes22(v):
                "bytes22(\(v))"
            case let .bytes23(v):
                "bytes23(\(v))"
            case let .bytes24(v):
                "bytes24(\(v))"
            case let .bytes25(v):
                "bytes25(\(v))"
            case let .bytes26(v):
                "bytes26(\(v))"
            case let .bytes27(v):
                "bytes27(\(v))"
            case let .bytes28(v):
                "bytes28(\(v))"
            case let .bytes29(v):
                "bytes29(\(v))"
            case let .bytes30(v):
                "bytes30(\(v))"
            case let .bytes31(v):
                "bytes31(\(v))"
            case let .bytes32(v):
                "bytes32(\(v))"
            case let .string(s):
                "string(\(s))"
            case let .arrayN(schema, n, values):
                "\(schema)[\(n)](\(values.map { $0.description }))"
            case let .array(schema, values):
                "\(schema)[](\(values.map { $0.description }))"
            case let .tupleN(values):
                "tuple(\(values.map { $0.description }))"
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16, .tuple17, .tuple18, .tuple19, .tuple20, .tuple21, .tuple22, .tuple23, .tuple24, .tuple25, .tuple26, .tuple27, .tuple28, .tuple29, .tuple30, .tuple31, .tuple32, .tuple33, .tuple34, .tuple35, .tuple36, .tuple37, .tuple38, .tuple39, .tuple40, .tuple41, .tuple42, .tuple43, .tuple44, .tuple45, .tuple46, .tuple47, .tuple48, .tuple49, .tuple50:
                asTupleN!.description
            }
        }

        /// Attempts to return a string representing this value. Note: this is best effort and really meant to be used for forge's `cast` tool!
        public var jsonValue: String {
            switch self {
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
                return "\"\(v.address.hex)\""
            case let .bytes(d):
                return "\"\(d.hex)\""
            case let .bytes1(d), let .bytes2(d), let .bytes3(d), let .bytes4(d), let .bytes5(d), let .bytes6(d), let .bytes7(d), let .bytes8(d), let .bytes9(d), let .bytes10(d), let .bytes11(d), let .bytes12(d), let .bytes13(d), let .bytes14(d), let .bytes15(d), let .bytes16(d), let .bytes17(d), let .bytes18(d), let .bytes19(d), let .bytes20(d), let .bytes21(d), let .bytes22(d), let .bytes23(d), let .bytes24(d), let .bytes25(d), let .bytes26(d), let .bytes27(d), let .bytes28(d), let .bytes29(d), let .bytes30(d), let .bytes31(d), let .bytes32(d):
                return "\"\(d.hex)\""
            case let .string(v):
                return "\"\(v.description)\""
            case let .array(_, v):
                return "'[\(v.map { $0.jsonValue }.joined(separator: ","))]'"
            case let .arrayN(_, _, v):
                return "'[\(v.map { $0.jsonValue }.joined(separator: ","))]'"
            case let .tupleN(v):
                return "'(\(v.map { $0.jsonValue }.joined(separator: ",")))'"
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16, .tuple17, .tuple18, .tuple19, .tuple20, .tuple21, .tuple22, .tuple23, .tuple24, .tuple25, .tuple26, .tuple27, .tuple28, .tuple29, .tuple30, .tuple31, .tuple32, .tuple33, .tuple34, .tuple35, .tuple36, .tuple37, .tuple38, .tuple39, .tuple40, .tuple41, .tuple42, .tuple43, .tuple44, .tuple45, .tuple46, .tuple47, .tuple48, .tuple49, .tuple50:
                return asTupleN!.jsonValue
            }
        }
    }
}

/** Pads a data with 00's on the right side until it matches a 32-byte word boundary */
private func padRightToWordBoundary(_ hex: Hex) -> Data {
    let data = hex.data
    let paddingSize = (data.count % 32 == 0) ? 0 : 32 - (data.count % 32)
    let padding = Data(repeating: 0, count: paddingSize)
    return data + padding
}

private func encodeVariableSizedData(data: Data) -> Data {
    return EthWord(fromInt: data.count)!.data + padRightToWordBoundary(Hex(data))
}

private func clamped(uint x: UInt, to limits: ClosedRange<UInt>) -> UInt {
    return min(max(x, limits.lowerBound), limits.upperBound)
}

private func clamped(int x: Int, to limits: ClosedRange<Int>) -> Int {
    return min(max(x, limits.lowerBound), limits.upperBound)
}

private func clamped(number x: Number, to limits: ClosedRange<Number>) -> Number {
    return min(max(x, limits.lowerBound), limits.upperBound)
}

private func clamped(sNumber x: SNumber, to limits: ClosedRange<SNumber>) -> SNumber {
    return min(max(x, limits.lowerBound), limits.upperBound)
}
