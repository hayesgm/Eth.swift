import BigInt
import Foundation

public extension ABI {
    /**
     * A field that can be decoded from or encoded to an Ethereum ABI value.
     *
     * Example:
     * ```
     * let encoded = .uint256(BigUInt(0x55)).encoded
     * // encoded -> 0x0000000000000000000000000000000000000000000000000000000000000055
     * ```
     *
     * Notes:
     *   - Small integers (≤32 bits) are represented as `UInt` or `Int` values. Larger values are represented as `BigUInt` or `BigInt`.
     *   - Tuples are canonically represented for easy pattern matching, e.g., `.tuple2(.uint256, .uint256)`. For tuples with more than 16 values, use `.tupleN([.uint256, ...])`.
     */

    enum Field: Equatable, CustomStringConvertible {
        // Unsigned Int
        case uint8(UInt)
        case uint16(UInt)
        case uint24(UInt)
        case uint32(UInt)
        case uint40(BigUInt)
        case uint48(BigUInt)
        case uint56(BigUInt)
        case uint64(BigUInt)
        case uint72(BigUInt)
        case uint80(BigUInt)
        case uint88(BigUInt)
        case uint96(BigUInt)
        case uint104(BigUInt)
        case uint112(BigUInt)
        case uint120(BigUInt)
        case uint128(BigUInt)
        case uint136(BigUInt)
        case uint144(BigUInt)
        case uint152(BigUInt)
        case uint160(BigUInt)
        case uint168(BigUInt)
        case uint176(BigUInt)
        case uint184(BigUInt)
        case uint192(BigUInt)
        case uint200(BigUInt)
        case uint208(BigUInt)
        case uint216(BigUInt)
        case uint224(BigUInt)
        case uint232(BigUInt)
        case uint240(BigUInt)
        case uint248(BigUInt)
        case uint256(BigUInt)

        // Signed Int
        case int8(Int)
        case int16(Int)
        case int24(Int)
        case int32(Int)
        case int40(BigInt)
        case int48(BigInt)
        case int56(BigInt)
        case int64(BigInt)
        case int72(BigInt)
        case int80(BigInt)
        case int88(BigInt)
        case int96(BigInt)
        case int104(BigInt)
        case int112(BigInt)
        case int120(BigInt)
        case int128(BigInt)
        case int136(BigInt)
        case int144(BigInt)
        case int152(BigInt)
        case int160(BigInt)
        case int168(BigInt)
        case int176(BigInt)
        case int184(BigInt)
        case int192(BigInt)
        case int200(BigInt)
        case int208(BigInt)
        case int216(BigInt)
        case int224(BigInt)
        case int232(BigInt)
        case int240(BigInt)
        case int248(BigInt)
        case int256(BigInt)

        // Bool
        case bool(Bool)

        // Address
        case address(EthAddress)

        // Dynamic Bytes
        case bytes(Data)

        case bytes1(Data)
        case bytes2(Data)
        case bytes3(Data)
        case bytes4(Data)
        case bytes5(Data)
        case bytes6(Data)
        case bytes7(Data)
        case bytes8(Data)
        case bytes9(Data)
        case bytes10(Data)
        case bytes11(Data)
        case bytes12(Data)
        case bytes13(Data)
        case bytes14(Data)
        case bytes15(Data)
        case bytes16(Data)
        case bytes17(Data)
        case bytes18(Data)
        case bytes19(Data)
        case bytes20(Data)
        case bytes21(Data)
        case bytes22(Data)
        case bytes23(Data)
        case bytes24(Data)
        case bytes25(Data)
        case bytes26(Data)
        case bytes27(Data)
        case bytes28(Data)
        case bytes29(Data)
        case bytes30(Data)
        case bytes31(Data)
        case bytes32(Data)

        // String
        case string(String)

        // Arrays
        case arrayN(Schema, Int, [Field])
        case array(Schema, [Field])

        // Tuples
        case tuple0
        indirect case tuple1(Field)
        indirect case tuple2(Field, Field)
        indirect case tuple3(Field, Field, Field)
        indirect case tuple4(Field, Field, Field, Field)
        indirect case tuple5(Field, Field, Field, Field, Field)
        indirect case tuple6(Field, Field, Field, Field, Field, Field)
        indirect case tuple7(Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple8(Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple9(Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple10(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple11(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple12(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple13(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple14(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple15(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tuple16(Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field, Field)
        indirect case tupleN([Field])

        /// Returns a `String` if Field contains a `.string`, otherwise nil
        public var asString: String? {
            switch self {
            case let .string(x):
                x
            default:
                nil
            }
        }

        /// Returns an `Int` if Field contains a 32-byte or smaller signed `.int`, otherwise nil
        public var asInt: Int? {
            switch self {
            case let .int8(x), let .int16(x), let .int24(x), let .int32(x):
                x
            default:
                nil
            }
        }

        /// Returns an `UInt` if Field contains a 32-byte or smaller `.uint`, otherwise nil
        public var asUInt: UInt? {
            switch self {
            case let .uint8(x), let .uint16(x), let .uint24(x), let .uint32(x):
                x
            default:
                nil
            }
        }

        /// Returns an `BigUInt` if Field contains any `.uint` value, otherwise nil
        public var asBigUInt: BigUInt? {
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
                BigUInt(x)
            default:
                nil
            }
        }

        /// Returns an `BigInt` if Field contains any signed `.int` value, otherwise nil
        public var asBigInt: BigInt? {
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
                BigInt(x)
            default:
                nil
            }
        }

        /// Returns an `Bool` if Field contains a `.bool`, otherwise nil
        public var asBool: Bool? {
            switch self {
            case let .bool(x):
                x
            default:
                nil
            }
        }

        /// Returns an `EthAddress` if Field contains a `.address`, otherwise nil
        public var asEthAddress: EthAddress? {
            switch self {
            case let .address(x):
                x
            default:
                nil
            }
        }

        /// Returns an `Data` if Field contains a fixed or variable-sized `.bytes`, otherwise nil
        public var asData: Data? {
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

        /// Returns an `Array` if Field contains a fixed or variable-sized `.array` or any `.tuple`, otherwise nil
        public var asArray: [Field]? {
            switch self {
            case let .arrayN(_, _, fields):
                fields
            case let .array(_, fields):
                fields
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16, .tupleN:
                tupleFields
            default:
                nil
            }
        }

        /// If the type is a tuple, returns a tupleN variant (e.g. `tuple1(.uint256)` to `.tupleN([.uint256])`)
        public var asTupleN: Field? {
            if let tupleFields {
                .tupleN(tupleFields)
            } else {
                nil
            }
        }

        /// Returns the associated Schema for this field
        public var fieldType: Schema {
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
            case let .arrayN(fieldType, n, _):
                .arrayN(fieldType, n)
            case let .array(fieldType, _):
                .array(fieldType)
            case let .tupleN(fields):
                .tuple(fields.map { $0.fieldType })
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16:
                asTupleN!.fieldType
            }
        }

        static func tupleFromFields(_ fields: [Field]) -> Field {
            switch fields.count {
            case 0:
                return .tuple0
            case 1:
                return .tuple1(fields[0])
            case 2:
                return .tuple2(fields[0], fields[1])
            case 3:
                return .tuple3(fields[0], fields[1], fields[2])
            case 4:
                return .tuple4(fields[0], fields[1], fields[2], fields[3])
            case 5:
                return .tuple5(fields[0], fields[1], fields[2], fields[3], fields[4])
            case 6:
                return .tuple6(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5])
            case 7:
                return .tuple7(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6])
            case 8:
                return .tuple8(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7])
            case 9:
                return .tuple9(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8])
            case 10:
                return .tuple10(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9])
            case 11:
                return .tuple11(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10])
            case 12:
                return .tuple12(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11])
            case 13:
                return .tuple13(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11], fields[12])
            case 14:
                return .tuple14(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11], fields[12], fields[13])
            case 15:
                return .tuple15(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11], fields[12], fields[13], fields[14])
            case 16:
                return .tuple16(fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11], fields[12], fields[13], fields[14], fields[15])
            default:
                return .tupleN(fields)
            }
        }

        private var tupleFields: [Field]? {
            switch self {
            case .tuple0:
                return []
            case let .tuple1(field0):
                return [field0]
            case let .tuple2(field0, field1):
                return [field0, field1]
            case let .tuple3(field0, field1, field2):
                return [field0, field1, field2]
            case let .tuple4(field0, field1, field2, field3):
                return [field0, field1, field2, field3]
            case let .tuple5(field0, field1, field2, field3, field4):
                return [field0, field1, field2, field3, field4]
            case let .tuple6(field0, field1, field2, field3, field4, field5):
                return [field0, field1, field2, field3, field4, field5]
            case let .tuple7(field0, field1, field2, field3, field4, field5, field6):
                return [field0, field1, field2, field3, field4, field5, field6]
            case let .tuple8(field0, field1, field2, field3, field4, field5, field6, field7):
                return [field0, field1, field2, field3, field4, field5, field6, field7]
            case let .tuple9(field0, field1, field2, field3, field4, field5, field6, field7, field8):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8]
            case let .tuple10(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9]
            case let .tuple11(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10]
            case let .tuple12(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11]
            case let .tuple13(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12]
            case let .tuple14(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13]
            case let .tuple15(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14]
            case let .tuple16(field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14, field15):
                return [field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14, field15]
            case let .tupleN(fields):
                return fields
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
         * Encodes the given input as ABI-encoded `Data`.
         *
         * This method never fails, but be aware of the following edge cases:
         *   - Integer values are clamped to their bounds. For example, `.uint8(999)` will be treated as `uint8(255)`.
         *   - String values must be UTF-8 encodable; otherwise, they will be treated as an empty string `""`.
         *
         * Example:
         * ```
         * let encoded = .uint256(BigUInt(0x55)).encoded
         * // encoded -> 0x0000000000000000000000000000000000000000000000000000000000000055
         * ```
         *
         * - Returns: An ABI-encoded `Data` representation of the input.
         */
        public var encoded: Data {
            switch self {
            case let .uint8(v), let .uint16(v), let .uint24(v), let .uint32(v):
                let bits = self.bits!
                let max: UInt = (1 << bits) - 1
                let clamped = clamped(uint: v, to: 0 ... max)
                return EthWord(fromUInt: clamped)!.data
            case let .uint40(v), let .uint48(v), let .uint56(v), let .uint64(v), let .uint72(v), let .uint80(v), let .uint88(v), let .uint96(v), let .uint104(v), let .uint112(v), let .uint120(v), let .uint128(v), let .uint136(v), let .uint144(v), let .uint152(v), let .uint160(v), let .uint168(v), let .uint176(v), let .uint184(v), let .uint192(v), let .uint200(v), let .uint208(v), let .uint216(v), let .uint224(v), let .uint232(v), let .uint240(v), let .uint248(v), let .uint256(v):
                let bits = self.bits!
                let max: BigUInt = (BigUInt(1) << bits) - 1
                let clamped = clamped(bigUInt: v, to: 0 ... max)
                return EthWord(fromBigUInt: clamped)!.data
            case let .int8(v), let .int16(v), let .int24(v), let .int32(v):
                let bits = self.bits!
                let max: Int = (1 << (bits - 1)) - 1
                let min: Int = -(1 << (bits - 1))
                let clamped = clamped(int: v, to: min ... max)
                return EthWord(fromInt: clamped)!.data
            case let .int40(v), let .int48(v), let .int56(v), let .int64(v), let .int72(v), let .int80(v), let .int88(v), let .int96(v), let .int104(v), let .int112(v), let .int120(v), let .int128(v), let .int136(v), let .int144(v), let .int152(v), let .int160(v), let .int168(v), let .int176(v), let .int184(v), let .int192(v), let .int200(v), let .int208(v), let .int216(v), let .int224(v), let .int232(v), let .int240(v), let .int248(v), let .int256(v):
                let bits = self.bits!
                let max: BigInt = (BigInt(1) << (bits - 1)) - 1
                let min: BigInt = -(BigInt(1) << (bits - 1))
                let clamped = clamped(bigInt: v, to: min ... max)
                return EthWord(fromBigInt: clamped)!.data
            case let .bool(b):
                // Zero and one are guaranteed to fit in an EthWord, QED
                return EthWord(fromUInt: b ? 1 : 0)!.data
            case let .address(v):
                // Address is guaranteed to be 20-bytes which fits in an EthWord, QED
                return EthWord(dataExtending: v.address)!.data
            case let .bytes(d):
                return encodeVariableSizedData(data: d)
            case let .bytes1(v):
                return padRightToWordBoundary(v)
            case let .bytes2(v):
                return padRightToWordBoundary(v)
            case let .bytes3(v):
                return padRightToWordBoundary(v)
            case let .bytes4(v):
                return padRightToWordBoundary(v)
            case let .bytes5(v):
                return padRightToWordBoundary(v)
            case let .bytes6(v):
                return padRightToWordBoundary(v)
            case let .bytes7(v):
                return padRightToWordBoundary(v)
            case let .bytes8(v):
                return padRightToWordBoundary(v)
            case let .bytes9(v):
                return padRightToWordBoundary(v)
            case let .bytes10(v):
                return padRightToWordBoundary(v)
            case let .bytes11(v):
                return padRightToWordBoundary(v)
            case let .bytes12(v):
                return padRightToWordBoundary(v)
            case let .bytes13(v):
                return padRightToWordBoundary(v)
            case let .bytes14(v):
                return padRightToWordBoundary(v)
            case let .bytes15(v):
                return padRightToWordBoundary(v)
            case let .bytes16(v):
                return padRightToWordBoundary(v)
            case let .bytes17(v):
                return padRightToWordBoundary(v)
            case let .bytes18(v):
                return padRightToWordBoundary(v)
            case let .bytes19(v):
                return padRightToWordBoundary(v)
            case let .bytes20(v):
                return padRightToWordBoundary(v)
            case let .bytes21(v):
                return padRightToWordBoundary(v)
            case let .bytes22(v):
                return padRightToWordBoundary(v)
            case let .bytes23(v):
                return padRightToWordBoundary(v)
            case let .bytes24(v):
                return padRightToWordBoundary(v)
            case let .bytes25(v):
                return padRightToWordBoundary(v)
            case let .bytes26(v):
                return padRightToWordBoundary(v)
            case let .bytes27(v):
                return padRightToWordBoundary(v)
            case let .bytes28(v):
                return padRightToWordBoundary(v)
            case let .bytes29(v):
                return padRightToWordBoundary(v)
            case let .bytes30(v):
                return padRightToWordBoundary(v)
            case let .bytes31(v):
                return padRightToWordBoundary(v)
            case let .bytes32(v):
                return padRightToWordBoundary(v)
            case let .string(s):
                // If the string isn't valid UTF8, this will return an empty string encoding.
                // Swift doesn't make it easy to generate an invalid UTF-8 string.
                if let string = s.data(using: .utf8) {
                    return encodeVariableSizedData(data: string)
                } else {
                    return encodeVariableSizedData(data: Data())
                }
            case let .arrayN(_, _, fields):
                return Field.tupleN(fields).encoded
            case let .array(_, fields):
                // Arrays simply concat their elements
                let encodedFields = Field.tupleN(fields).encoded
                // Note: we'll assert that fields.count will always fit nicely into an EthWord
                let size = EthWord(fromInt: fields.count)!.data
                return size + encodedFields
            case let .tupleN(fields):
                // For a tuple, we encode non-dynamic types in-place ("prim") and dynamic types in a "heap"
                let primarySizeBytes = fields.map { $0.fieldType.primaryWordSize }.reduce(0) { $0 + $1 } * 0x20
                let (prim, heap) = fields.reduce((Data(), Data())) { acc, field in
                    let (prim, heap) = acc
                    if field.fieldType.dynamic {
                        return (prim + EthWord(fromInt: primarySizeBytes + heap.count)!.data, heap + field.encoded)
                    } else {
                        return (prim + field.encoded, heap)
                    }
                }
                return prim + heap
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16:
                return asTupleN!.encoded
            }
        }

        /// Returns a friendly description of a given value, e.g. `.uint256(0x55) -> "uint256(0x55)"`)
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
                "address(\(Hex.toHex(v.address)))"
            case let .bytes(d):
                "bytes(\(Hex.toHex(d)))"
            case let .bytes1(v):
                "bytes1(\(Hex.toHex(v)))"
            case let .bytes2(v):
                "bytes2(\(Hex.toHex(v)))"
            case let .bytes3(v):
                "bytes3(\(Hex.toHex(v)))"
            case let .bytes4(v):
                "bytes4(\(Hex.toHex(v)))"
            case let .bytes5(v):
                "bytes5(\(Hex.toHex(v)))"
            case let .bytes6(v):
                "bytes6(\(Hex.toHex(v)))"
            case let .bytes7(v):
                "bytes7(\(Hex.toHex(v)))"
            case let .bytes8(v):
                "bytes8(\(Hex.toHex(v)))"
            case let .bytes9(v):
                "bytes9(\(Hex.toHex(v)))"
            case let .bytes10(v):
                "bytes10(\(Hex.toHex(v)))"
            case let .bytes11(v):
                "bytes11(\(Hex.toHex(v)))"
            case let .bytes12(v):
                "bytes12(\(Hex.toHex(v)))"
            case let .bytes13(v):
                "bytes13(\(Hex.toHex(v)))"
            case let .bytes14(v):
                "bytes14(\(Hex.toHex(v)))"
            case let .bytes15(v):
                "bytes15(\(Hex.toHex(v)))"
            case let .bytes16(v):
                "bytes16(\(Hex.toHex(v)))"
            case let .bytes17(v):
                "bytes17(\(Hex.toHex(v)))"
            case let .bytes18(v):
                "bytes18(\(Hex.toHex(v)))"
            case let .bytes19(v):
                "bytes19(\(Hex.toHex(v)))"
            case let .bytes20(v):
                "bytes20(\(Hex.toHex(v)))"
            case let .bytes21(v):
                "bytes21(\(Hex.toHex(v)))"
            case let .bytes22(v):
                "bytes22(\(Hex.toHex(v)))"
            case let .bytes23(v):
                "bytes23(\(Hex.toHex(v)))"
            case let .bytes24(v):
                "bytes24(\(Hex.toHex(v)))"
            case let .bytes25(v):
                "bytes25(\(Hex.toHex(v)))"
            case let .bytes26(v):
                "bytes26(\(Hex.toHex(v)))"
            case let .bytes27(v):
                "bytes27(\(Hex.toHex(v)))"
            case let .bytes28(v):
                "bytes28(\(Hex.toHex(v)))"
            case let .bytes29(v):
                "bytes29(\(Hex.toHex(v)))"
            case let .bytes30(v):
                "bytes30(\(Hex.toHex(v)))"
            case let .bytes31(v):
                "bytes31(\(Hex.toHex(v)))"
            case let .bytes32(v):
                "bytes32(\(Hex.toHex(v)))"
            case let .string(s):
                "string(\(s))"
            case let .arrayN(fieldType, n, fields):
                "\(fieldType)[\(n)](\(fields.map { $0.description }))"
            case let .array(fieldType, fields):
                "\(fieldType)[](\(fields.map { $0.description }))"
            case let .tupleN(fields):
                "tuple(\(fields.map { $0.description }))"
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16:
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
                return "\"\(Hex.toHex(v.address))\""
            case let .bytes(d):
                return "\"\(Hex.toHex(d))\""
            case let .bytes1(d), let .bytes2(d), let .bytes3(d), let .bytes4(d), let .bytes5(d), let .bytes6(d), let .bytes7(d), let .bytes8(d), let .bytes9(d), let .bytes10(d), let .bytes11(d), let .bytes12(d), let .bytes13(d), let .bytes14(d), let .bytes15(d), let .bytes16(d), let .bytes17(d), let .bytes18(d), let .bytes19(d), let .bytes20(d), let .bytes21(d), let .bytes22(d), let .bytes23(d), let .bytes24(d), let .bytes25(d), let .bytes26(d), let .bytes27(d), let .bytes28(d), let .bytes29(d), let .bytes30(d), let .bytes31(d), let .bytes32(d):
                return "\"\(Hex.toHex(d))\""
            case let .string(v):
                return "\"\(v.description)\""
            case let .array(_, v):
                return "'[\(v.map { $0.jsonValue }.joined(separator: ","))]'"
            case let .arrayN(_, _, v):
                return "'[\(v.map { $0.jsonValue }.joined(separator: ","))]'"
            case let .tupleN(v):
                return "'(\(v.map { $0.jsonValue }.joined(separator: ",")))'"
            case .tuple0, .tuple1, .tuple2, .tuple3, .tuple4, .tuple5, .tuple6, .tuple7, .tuple8, .tuple9, .tuple10, .tuple11, .tuple12, .tuple13, .tuple14, .tuple15, .tuple16:
                return asTupleN!.jsonValue
            }
        }
    }
}

/** Pads a data with 00's on the right side until it matches a 32-byte word boundary */
private func padRightToWordBoundary(_ data: Data) -> Data {
    let paddingSize = (data.count % 32 == 0) ? 0 : 32 - (data.count % 32)
    let padding = Data(repeating: 0, count: paddingSize)
    return data + padding
}

private func encodeVariableSizedData(data: Data) -> Data {
    return EthWord(fromInt: data.count)!.data + padRightToWordBoundary(data)
}

private func clamped(uint x: UInt, to limits: ClosedRange<UInt>) -> UInt {
    return min(max(x, limits.lowerBound), limits.upperBound)
}

private func clamped(int x: Int, to limits: ClosedRange<Int>) -> Int {
    return min(max(x, limits.lowerBound), limits.upperBound)
}

private func clamped(bigUInt x: BigUInt, to limits: ClosedRange<BigUInt>) -> BigUInt {
    return min(max(x, limits.lowerBound), limits.upperBound)
}

private func clamped(bigInt x: BigInt, to limits: ClosedRange<BigInt>) -> BigInt {
    return min(max(x, limits.lowerBound), limits.upperBound)
}
