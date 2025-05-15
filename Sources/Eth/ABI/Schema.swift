import BigInt
import Foundation

public extension ABI {
    /**
     An enumeration of errors that can occur during decoding.

     - insufficientData: The data did not have sufficient data to decode the schema. This may be in a sub-decoding of a tuple or array.
     - excessData: There is excess data left after decoding the schema.
     - nonEmptyDataFound: A size limited value had bits set unexpectedly (e.g. a uint8 had any of the first 248 bits set).
     - integerOverflow: An integer overflow occurred during decoding unexpectedly. Generally this means that a string or variable-sized data reported its size to be more than 2^64 bytes.
     - sizedUnsignedIntegerOverflow: An overflow occurred for a sized unsigned integer. E.g. uint8 overflows 8-bits
     - sizedSignedIntegerOverflow: An overflow occurred for a sized signed integer. E.g. int8 overflows 8-bits
     - invalidDataPointer: The data pointer is invalid. Specifically this is when the pointer to a dynamic size item doesn't fit in 2^64 bits.
     - invalidDataHeapPointer: The data heap pointer is invalid. Generally this is when a pointer to a dynamic size item points to an area that's previous to another element or not on a 32-byte boundary.
     - invalidUtf8String: A UTF-8 string is invalid.
     - invalidAddress: An address is not a proper 20-byte Ethereum address.
     - unexpectedError: An unexpected error occurred. These are for truly exceptional events that should not occur.
     - mismatchedType: The types provided do not match the schema.
     - invalidResponse: The response is invalid.
     */
    enum DecodeError: Error, Equatable, Sendable {
        case insufficientData(Schema, Hex)
        case excessData(Schema, Hex)
        case nonEmptyDataFound(Schema, Hex)
        case integerOverflow(Schema, Hex)
        case sizedUnsignedIntegerOverflow(Int, Hex)
        case sizedSignedIntegerOverflow(Int, Hex)
        case invalidDataPointer(Schema, Hex)
        case invalidDataHeapPointer(Schema, Int?, Int, Hex)
        case invalidUtf8String(Hex)
        case invalidAddress(Hex)
        case unexpectedError(String)
        case mismatchedType(Schema, Schema)
        case invalidResponse
    }

    /**
     An enumeration of all possible Solidity ABI types (e.g. `.uint256` for "uint256", `.tuple([.array(.string)])` for "(string[])")
     */
    enum Schema: Equatable, CustomStringConvertible, Sendable {
        // Unsigned Int
        case uint8
        case uint16
        case uint24
        case uint32
        case uint40
        case uint48
        case uint56
        case uint64
        case uint72
        case uint80
        case uint88
        case uint96
        case uint104
        case uint112
        case uint120
        case uint128
        case uint136
        case uint144
        case uint152
        case uint160
        case uint168
        case uint176
        case uint184
        case uint192
        case uint200
        case uint208
        case uint216
        case uint224
        case uint232
        case uint240
        case uint248
        case uint256

        // Signed Int
        case int8
        case int16
        case int24
        case int32
        case int40
        case int48
        case int56
        case int64
        case int72
        case int80
        case int88
        case int96
        case int104
        case int112
        case int120
        case int128
        case int136
        case int144
        case int152
        case int160
        case int168
        case int176
        case int184
        case int192
        case int200
        case int208
        case int216
        case int224
        case int232
        case int240
        case int248
        case int256

        // Bool
        case bool

        // Address
        case address

        // Dynamic Bytes
        case bytes

        // BytesN
        case bytes1
        case bytes2
        case bytes3
        case bytes4
        case bytes5
        case bytes6
        case bytes7
        case bytes8
        case bytes9
        case bytes10
        case bytes11
        case bytes12
        case bytes13
        case bytes14
        case bytes15
        case bytes16
        case bytes17
        case bytes18
        case bytes19
        case bytes20
        case bytes21
        case bytes22
        case bytes23
        case bytes24
        case bytes25
        case bytes26
        case bytes27
        case bytes28
        case bytes29
        case bytes30
        case bytes31
        case bytes32

        // String
        case string

        // Arrays
        indirect case arrayN(Schema, Int)
        indirect case array(Schema)

        // Tuple
        indirect case tuple([Schema])

        /// The Solidity canonical form of the given schema, e.g. `uint256[]`.
        public var canonical: String {
            switch self {
            case .uint8:
                return "uint8"
            case .uint16:
                return "uint16"
            case .uint24:
                return "uint24"
            case .uint32:
                return "uint32"
            case .uint40:
                return "uint40"
            case .uint48:
                return "uint48"
            case .uint56:
                return "uint56"
            case .uint64:
                return "uint64"
            case .uint72:
                return "uint72"
            case .uint80:
                return "uint80"
            case .uint88:
                return "uint88"
            case .uint96:
                return "uint96"
            case .uint104:
                return "uint104"
            case .uint112:
                return "uint112"
            case .uint120:
                return "uint120"
            case .uint128:
                return "uint128"
            case .uint136:
                return "uint136"
            case .uint144:
                return "uint144"
            case .uint152:
                return "uint152"
            case .uint160:
                return "uint160"
            case .uint168:
                return "uint168"
            case .uint176:
                return "uint176"
            case .uint184:
                return "uint184"
            case .uint192:
                return "uint192"
            case .uint200:
                return "uint200"
            case .uint208:
                return "uint208"
            case .uint216:
                return "uint216"
            case .uint224:
                return "uint224"
            case .uint232:
                return "uint232"
            case .uint240:
                return "uint240"
            case .uint248:
                return "uint248"
            case .uint256:
                return "uint256"
            case .int8:
                return "int8"
            case .int16:
                return "int16"
            case .int24:
                return "int24"
            case .int32:
                return "int32"
            case .int40:
                return "int40"
            case .int48:
                return "int48"
            case .int56:
                return "int56"
            case .int64:
                return "int64"
            case .int72:
                return "int72"
            case .int80:
                return "int80"
            case .int88:
                return "int88"
            case .int96:
                return "int96"
            case .int104:
                return "int104"
            case .int112:
                return "int112"
            case .int120:
                return "int120"
            case .int128:
                return "int128"
            case .int136:
                return "int136"
            case .int144:
                return "int144"
            case .int152:
                return "int152"
            case .int160:
                return "int160"
            case .int168:
                return "int168"
            case .int176:
                return "int176"
            case .int184:
                return "int184"
            case .int192:
                return "int192"
            case .int200:
                return "int200"
            case .int208:
                return "int208"
            case .int216:
                return "int216"
            case .int224:
                return "int224"
            case .int232:
                return "int232"
            case .int240:
                return "int240"
            case .int248:
                return "int248"
            case .int256:
                return "int256"
            case .bool:
                return "bool"
            case .address:
                return "address"
            case .bytes:
                return "bytes"
            case .bytes1:
                return "bytes1"
            case .bytes2:
                return "bytes2"
            case .bytes3:
                return "bytes3"
            case .bytes4:
                return "bytes4"
            case .bytes5:
                return "bytes5"
            case .bytes6:
                return "bytes6"
            case .bytes7:
                return "bytes7"
            case .bytes8:
                return "bytes8"
            case .bytes9:
                return "bytes9"
            case .bytes10:
                return "bytes10"
            case .bytes11:
                return "bytes11"
            case .bytes12:
                return "bytes12"
            case .bytes13:
                return "bytes13"
            case .bytes14:
                return "bytes14"
            case .bytes15:
                return "bytes15"
            case .bytes16:
                return "bytes16"
            case .bytes17:
                return "bytes17"
            case .bytes18:
                return "bytes18"
            case .bytes19:
                return "bytes19"
            case .bytes20:
                return "bytes20"
            case .bytes21:
                return "bytes21"
            case .bytes22:
                return "bytes22"
            case .bytes23:
                return "bytes23"
            case .bytes24:
                return "bytes24"
            case .bytes25:
                return "bytes25"
            case .bytes26:
                return "bytes26"
            case .bytes27:
                return "bytes27"
            case .bytes28:
                return "bytes28"
            case .bytes29:
                return "bytes29"
            case .bytes30:
                return "bytes30"
            case .bytes31:
                return "bytes31"
            case .bytes32:
                return "bytes32"
            case .string:
                return "string"
            case let .arrayN(schema, size):
                return "\(schema.description)[\(size)]"
            case let .array(schema):
                return "\(schema.description)[]"
            case let .tuple(values):
                return "(\(values.map { $0.description }.joined(separator: ",")))"
            }
        }

        public var description: String {
            canonical
        }

        var dynamic: Bool {
            switch self {
            case .string, .bytes, .array:
                true
            case let .arrayN(schema, _):
                schema.dynamic
            case let .tuple(values):
                values.contains { $0.dynamic }
            default:
                false
            }
        }

        var primaryWordSize: Int {
            if !dynamic, case let .tuple(values) = self {
                // Tuples can have multiple values stored in the primary stack
                return values.map { $0.primaryWordSize }.reduce(0) { $0 + $1 }
            } else {
                return 1
            }
        }

        private func decodeTupleValues(data: Data, withSchemas schemas: [Schema]) throws -> [Value] {
            // We're going to get the right data slices for each sub-value

            struct ValuePartial {
                let index: Int
                let schema: Schema
                let primaryData: Data
                var heapStart: Int? = nil
            }

            var valuePartials: [ValuePartial] = []
            var offset = 0

            // First pass, we get the primary data and heap pointer for dynamic data
            // We need these to determine the heap end marker when decoding
            for (i, schema) in schemas.enumerated() {
                let primaryData = try getPrimaryData(offset: offset, fromData: data, forSchema: schema)
                var valuePartial = ValuePartial(index: i, schema: schema, primaryData: primaryData)
                if schema.dynamic {
                    guard let heapStart = EthWord(fromData: primaryData)?.toInt() else {
                        throw DecodeError.invalidDataPointer(schema, Hex(primaryData))
                    }
                    valuePartial.heapStart = heapStart
                }
                valuePartials.append(valuePartial)
                offset += primaryData.count
            }

            var values: [Value] = []

            // Second pass, we fill in the `valueData` values for all values and decode them
            for valuePartial in valuePartials {
                let valueData: Data

                if valuePartial.schema.dynamic {
                    let nextValuePartials = valuePartials.dropFirst(valuePartial.index + 1)
                    let heapEnd = findFirst(nextValuePartials) { $0.heapStart } ?? data.count
                    guard let heapStart = valuePartial.heapStart, heapEnd <= data.count, heapEnd > heapStart, heapEnd % 32 == 0 else {
                        throw DecodeError.invalidDataHeapPointer(valuePartial.schema, valuePartial.heapStart, heapEnd, Hex(data))
                    }
                    valueData = data.subdata(in: heapStart ..< heapEnd)
                } else {
                    valueData = valuePartial.primaryData
                }

                try values.append(valuePartial.schema.decode(Hex(valueData)))
            }

            return values
        }

        /**
         Decodes the provided data into a `Value` based on the `Schema`.

         - Parameter data: The data to decode.
         - Throws: `ABI.DecodeError` if the decoding fails.
         - Returns: A `Value` object representing the decoded data.
         */
        public func decode(_ hex: Hex) throws -> Value {
            let data = hex.data
            switch self {
            case .uint8:
                return try .uint8(decodeUIntSmall(data, inBits: 8, withSchema: self))
            case .uint16:
                return try .uint16(decodeUIntSmall(data, inBits: 16, withSchema: self))
            case .uint24:
                return try .uint24(decodeUIntSmall(data, inBits: 24, withSchema: self))
            case .uint32:
                return try .uint32(decodeUIntSmall(data, inBits: 32, withSchema: self))
            case .uint40:
                return try .uint40(decodeUInt(data, inBits: 40, withSchema: self))
            case .uint48:
                return try .uint48(decodeUInt(data, inBits: 48, withSchema: self))
            case .uint56:
                return try .uint56(decodeUInt(data, inBits: 56, withSchema: self))
            case .uint64:
                return try .uint64(decodeUInt(data, inBits: 64, withSchema: self))
            case .uint72:
                return try .uint72(decodeUInt(data, inBits: 72, withSchema: self))
            case .uint80:
                return try .uint80(decodeUInt(data, inBits: 80, withSchema: self))
            case .uint88:
                return try .uint88(decodeUInt(data, inBits: 88, withSchema: self))
            case .uint96:
                return try .uint96(decodeUInt(data, inBits: 96, withSchema: self))
            case .uint104:
                return try .uint104(decodeUInt(data, inBits: 104, withSchema: self))
            case .uint112:
                return try .uint112(decodeUInt(data, inBits: 112, withSchema: self))
            case .uint120:
                return try .uint120(decodeUInt(data, inBits: 120, withSchema: self))
            case .uint128:
                return try .uint128(decodeUInt(data, inBits: 128, withSchema: self))
            case .uint136:
                return try .uint136(decodeUInt(data, inBits: 136, withSchema: self))
            case .uint144:
                return try .uint144(decodeUInt(data, inBits: 144, withSchema: self))
            case .uint152:
                return try .uint152(decodeUInt(data, inBits: 152, withSchema: self))
            case .uint160:
                return try .uint160(decodeUInt(data, inBits: 160, withSchema: self))
            case .uint168:
                return try .uint168(decodeUInt(data, inBits: 168, withSchema: self))
            case .uint176:
                return try .uint176(decodeUInt(data, inBits: 176, withSchema: self))
            case .uint184:
                return try .uint184(decodeUInt(data, inBits: 184, withSchema: self))
            case .uint192:
                return try .uint192(decodeUInt(data, inBits: 192, withSchema: self))
            case .uint200:
                return try .uint200(decodeUInt(data, inBits: 200, withSchema: self))
            case .uint208:
                return try .uint208(decodeUInt(data, inBits: 208, withSchema: self))
            case .uint216:
                return try .uint216(decodeUInt(data, inBits: 216, withSchema: self))
            case .uint224:
                return try .uint224(decodeUInt(data, inBits: 224, withSchema: self))
            case .uint232:
                return try .uint232(decodeUInt(data, inBits: 232, withSchema: self))
            case .uint240:
                return try .uint240(decodeUInt(data, inBits: 240, withSchema: self))
            case .uint248:
                return try .uint248(decodeUInt(data, inBits: 248, withSchema: self))
            case .uint256:
                return try .uint256(decodeUInt(data, inBits: 256, withSchema: self))
            case .bool:
                return try .bool(decodeUIntSmall(data, inBits: 1, withSchema: self) == 1)
            case .address:
                if let ethAddress = try EthAddress(fromData: readRightBytesN(data, withSchema: self, bytes: 20)) {
                    return .address(ethAddress)
                } else {
                    throw DecodeError.invalidAddress(Hex(data))
                }
            case .int8:
                return try .int8(decodeIntSmall(data, inBits: 8, withSchema: self))
            case .int16:
                return try .int16(decodeIntSmall(data, inBits: 16, withSchema: self))
            case .int24:
                return try .int24(decodeIntSmall(data, inBits: 24, withSchema: self))
            case .int32:
                return try .int32(decodeIntSmall(data, inBits: 32, withSchema: self))
            case .int40:
                return try .int40(decodeInt(data, inBits: 40, withSchema: self))
            case .int48:
                return try .int48(decodeInt(data, inBits: 48, withSchema: self))
            case .int56:
                return try .int56(decodeInt(data, inBits: 56, withSchema: self))
            case .int64:
                return try .int64(decodeInt(data, inBits: 64, withSchema: self))
            case .int72:
                return try .int72(decodeInt(data, inBits: 72, withSchema: self))
            case .int80:
                return try .int80(decodeInt(data, inBits: 80, withSchema: self))
            case .int88:
                return try .int88(decodeInt(data, inBits: 88, withSchema: self))
            case .int96:
                return try .int96(decodeInt(data, inBits: 96, withSchema: self))
            case .int104:
                return try .int104(decodeInt(data, inBits: 104, withSchema: self))
            case .int112:
                return try .int112(decodeInt(data, inBits: 112, withSchema: self))
            case .int120:
                return try .int120(decodeInt(data, inBits: 120, withSchema: self))
            case .int128:
                return try .int128(decodeInt(data, inBits: 128, withSchema: self))
            case .int136:
                return try .int136(decodeInt(data, inBits: 136, withSchema: self))
            case .int144:
                return try .int144(decodeInt(data, inBits: 144, withSchema: self))
            case .int152:
                return try .int152(decodeInt(data, inBits: 152, withSchema: self))
            case .int160:
                return try .int160(decodeInt(data, inBits: 160, withSchema: self))
            case .int168:
                return try .int168(decodeInt(data, inBits: 168, withSchema: self))
            case .int176:
                return try .int176(decodeInt(data, inBits: 176, withSchema: self))
            case .int184:
                return try .int184(decodeInt(data, inBits: 184, withSchema: self))
            case .int192:
                return try .int192(decodeInt(data, inBits: 192, withSchema: self))
            case .int200:
                return try .int200(decodeInt(data, inBits: 200, withSchema: self))
            case .int208:
                return try .int208(decodeInt(data, inBits: 208, withSchema: self))
            case .int216:
                return try .int216(decodeInt(data, inBits: 216, withSchema: self))
            case .int224:
                return try .int224(decodeInt(data, inBits: 224, withSchema: self))
            case .int232:
                return try .int232(decodeInt(data, inBits: 232, withSchema: self))
            case .int240:
                return try .int240(decodeInt(data, inBits: 240, withSchema: self))
            case .int248:
                return try .int248(decodeInt(data, inBits: 248, withSchema: self))
            case .int256:
                return try .int256(decodeInt(data, inBits: 256, withSchema: self))
            case .bytes1:
                return try .bytes1(readBytesN(data, withSchema: self, bytes: 1))
            case .bytes2:
                return try .bytes2(readBytesN(data, withSchema: self, bytes: 2))
            case .bytes3:
                return try .bytes3(readBytesN(data, withSchema: self, bytes: 3))
            case .bytes4:
                return try .bytes4(readBytesN(data, withSchema: self, bytes: 4))
            case .bytes5:
                return try .bytes5(readBytesN(data, withSchema: self, bytes: 5))
            case .bytes6:
                return try .bytes6(readBytesN(data, withSchema: self, bytes: 6))
            case .bytes7:
                return try .bytes7(readBytesN(data, withSchema: self, bytes: 7))
            case .bytes8:
                return try .bytes8(readBytesN(data, withSchema: self, bytes: 8))
            case .bytes9:
                return try .bytes9(readBytesN(data, withSchema: self, bytes: 9))
            case .bytes10:
                return try .bytes10(readBytesN(data, withSchema: self, bytes: 10))
            case .bytes11:
                return try .bytes11(readBytesN(data, withSchema: self, bytes: 11))
            case .bytes12:
                return try .bytes12(readBytesN(data, withSchema: self, bytes: 12))
            case .bytes13:
                return try .bytes13(readBytesN(data, withSchema: self, bytes: 13))
            case .bytes14:
                return try .bytes14(readBytesN(data, withSchema: self, bytes: 14))
            case .bytes15:
                return try .bytes15(readBytesN(data, withSchema: self, bytes: 15))
            case .bytes16:
                return try .bytes16(readBytesN(data, withSchema: self, bytes: 16))
            case .bytes17:
                return try .bytes17(readBytesN(data, withSchema: self, bytes: 17))
            case .bytes18:
                return try .bytes18(readBytesN(data, withSchema: self, bytes: 18))
            case .bytes19:
                return try .bytes19(readBytesN(data, withSchema: self, bytes: 19))
            case .bytes20:
                return try .bytes20(readBytesN(data, withSchema: self, bytes: 20))
            case .bytes21:
                return try .bytes21(readBytesN(data, withSchema: self, bytes: 21))
            case .bytes22:
                return try .bytes22(readBytesN(data, withSchema: self, bytes: 22))
            case .bytes23:
                return try .bytes23(readBytesN(data, withSchema: self, bytes: 23))
            case .bytes24:
                return try .bytes24(readBytesN(data, withSchema: self, bytes: 24))
            case .bytes25:
                return try .bytes25(readBytesN(data, withSchema: self, bytes: 25))
            case .bytes26:
                return try .bytes26(readBytesN(data, withSchema: self, bytes: 26))
            case .bytes27:
                return try .bytes27(readBytesN(data, withSchema: self, bytes: 27))
            case .bytes28:
                return try .bytes28(readBytesN(data, withSchema: self, bytes: 28))
            case .bytes29:
                return try .bytes29(readBytesN(data, withSchema: self, bytes: 29))
            case .bytes30:
                return try .bytes30(readBytesN(data, withSchema: self, bytes: 30))
            case .bytes31:
                return try .bytes31(readBytesN(data, withSchema: self, bytes: 31))
            case .bytes32:
                return try .bytes32(readBytesN(data, withSchema: self, bytes: 32))
            case .bytes:
                let data = try loadVariableSizedData(data: data, withSchema: self)
                return .bytes(Hex(Data(data))) // Note: Data here is expressly copy in case we have a subdata
            case .string:
                let utf8Data = try loadVariableSizedData(data: data, withSchema: self)
                if let string = String(data: utf8Data, encoding: .utf8) {
                    return .string(string)
                } else {
                    throw DecodeError.invalidUtf8String(Hex(utf8Data))
                }
            case let .arrayN(schema, n):
                let schemas = arraySchemas(schema, n)
                let values = try decodeTupleValues(data: data, withSchemas: schemas)

                return .arrayN(schema, n, values)
            case let .array(schema):
                // We need to peek at the data size before each element
                // This is because there's no way to know the size of an
                // element before digging in.
                if data.count < 32 {
                    throw ABI.DecodeError.insufficientData(schema, Hex(data))
                }
                let elementCount = try decodeUIntSmall(data.subdata(in: 0 ..< 32), inBits: 32, withSchema: self)

                let schemas: [Schema] = (0 ..< elementCount).map { _ in schema }
                let subdata = data.dropFirst(32)

                let values = try decodeTupleValues(data: Data(subdata), withSchemas: schemas)

                return .array(schema, values)
            case let .tuple(schemas):
                let values = try decodeTupleValues(data: data, withSchemas: schemas)

                return Value.tupleFromValues(values)
            }
        }
    }
}

private func getPrimaryData(offset startIndex: Int, fromData data: Data, forSchema schema: ABI.Schema) throws -> Data {
    let endIndex = startIndex + schema.primaryWordSize * 32
    if data.count < endIndex {
        throw ABI.DecodeError.insufficientData(schema, Hex(data))
    }
    return data.subdata(in: startIndex ..< endIndex)
}

private func findFirst<T, U>(_ array: ArraySlice<T>, _ transform: (T) -> U?) -> U? {
    for element in array {
        if let result = transform(element) {
            return result
        }
    }
    return nil
}

private func loadVariableSizedData(data: Data, withSchema schema: ABI.Schema) throws -> Data {
    let (dataLen, rest) = try readInt(data, withSchema: schema)
    let wordLen = wordsRequiredForLength(dataLen)
    try checkDataSize(rest, words: wordLen, forSchema: schema)
    return rest.prefix(dataLen)
}

private func bigIntToInt(_ bigInt: BigInt) -> Int? {
    if bigInt >= BigInt(Int.min), bigInt <= BigInt(Int.max) {
        return Int(bigInt)
    } else {
        return nil
    }
}

private func bigUIntToUInt(_ bigUInt: BigUInt) -> UInt? {
    if bigUInt <= BigUInt(UInt.max) {
        return UInt(bigUInt)
    } else {
        return nil
    }
}

/** Decodes a word of data to a UInt or fails **/
private func decodeUIntSmall(_ data: Data, inBits bits: Int, withSchema schema: ABI.Schema) throws -> UInt {
    let bigUInt = try decodeUInt(data, inBits: bits, withSchema: schema)
    guard let int = bigUIntToUInt(bigUInt) else {
        throw ABI.DecodeError.sizedUnsignedIntegerOverflow(bits, Hex(data))
    }
    return int
}

/** Decodes a word of data to an Int or fails **/
private func decodeIntSmall(_ data: Data, inBits bits: Int, withSchema schema: ABI.Schema) throws -> Int {
    let bigInt = try decodeInt(data, inBits: bits, withSchema: schema)
    guard let int = bigIntToInt(bigInt) else {
        throw ABI.DecodeError.sizedSignedIntegerOverflow(bits, Hex(data))
    }
    return int
}

/** Decodes a word to a BigUInt **/
private func decodeUInt(_ data: Data, inBits bits: Int, withSchema schema: ABI.Schema) throws -> BigUInt {
    try toBigUInt(readExactSingleWord(data, withSchema: schema), bits: bits)
}

/** Decodes a word to a BigInt **/
private func decodeInt(_ data: Data, inBits bits: Int, withSchema schema: ABI.Schema) throws -> BigInt {
    try toBigInt(readExactSingleWord(data, withSchema: schema), bits: bits)
}

/** Sometimes we need to pack data into 32-byte words. This determines the minimum number of words needed
 *  to store the value. E.g. 1 -> 1, 32 -> 1, 33 -> 2, ... **/
private func wordsRequiredForLength(_ length: Int) -> Int {
    Int(ceil(Double(length) / 32.0))
}

/** Reads a 32-byte word and returns back the extra data, raises if insufficient data **/
private func readWord(_ data: Data, withSchema schema: ABI.Schema) throws -> (EthWord, Data) {
    if data.count >= 32, let word = EthWord(fromData: data.prefix(32)) {
        return (word, data.dropFirst(32))
    } else {
        throw ABI.DecodeError.insufficientData(schema, Hex(data))
    }
}

/** Reads an Int. Note: we'll raise a generic overflow if the value doesn't fit into an Int,
 *  since we only use this when things denote sizes. If something overflows even a 32-bit Int,
 *  then it's too large or a pointer that's beyond the end of the data (assuming there are not
 *  ≥4GB of data). I guess "famous last words". */
private func readInt(_ data: Data, withSchema schema: ABI.Schema) throws -> (Int, Data) {
    let (word, extra) = try readWord(data, withSchema: schema)
    guard let x = word.toInt() else {
        throw ABI.DecodeError.integerOverflow(schema, Hex(word.data))
    }
    return (x, extra)
}

/** Checks that the data is the exact size in 32-byte words, or raises. */
private func checkDataSize(_ data: Data, words: Int, forSchema schema: ABI.Schema) throws {
    if data.count == 32 * words {
        return
    } else if data.count < 32 * words {
        throw ABI.DecodeError.insufficientData(schema, Hex(data))
    } else {
        throw ABI.DecodeError.excessData(schema, Hex(data))
    }
}

/** Reads a single 32-byte word and returns it, iff the data is exactly 32-byte wide */
private func readExactSingleWord(_ data: Data, withSchema schema: ABI.Schema) throws -> EthWord {
    if data.count == 32, let word = EthWord(fromData: data) {
        return word
    } else if data.count < 32 {
        throw ABI.DecodeError.insufficientData(schema, Hex(data))
    } else {
        throw ABI.DecodeError.excessData(schema, Hex(data))
    }
}

/** Returns a BigUInt if the data fits within N bits **/
private func toBigUInt(_ word: EthWord, bits: Int) throws -> BigUInt {
    let x = word.toBigUInt()
    guard x < BigUInt(2).power(bits) else {
        throw ABI.DecodeError.sizedUnsignedIntegerOverflow(bits, Hex(word.data))
    }
    return x
}

/** Returns a BigInt if the data fits within N bits. Assumes two's complement encoding. **/
private func toBigInt(_ word: EthWord, bits: Int) throws -> BigInt {
    let x = word.toBigInt()
    let maxValue = BigInt(2).power(bits - 1)
    let minValue = BigInt(-2).power(bits - 1)

    guard x < maxValue, x >= minValue else {
        throw ABI.DecodeError.sizedSignedIntegerOverflow(bits, Hex(word.data))
    }
    return x
}

/** Reads the N most significant bytes of a 32-byte data value **/
private func readBytesN(_ data: Data, withSchema schema: ABI.Schema, bytes: Int) throws -> Hex {
    try checkDataSize(data, words: 1, forSchema: schema)
    guard BigUInt(data.suffix(32 - bytes)) == .zero else {
        throw ABI.DecodeError.nonEmptyDataFound(schema, Hex(data))
    }
    return Hex(data.prefix(bytes))
}

/** Reads the N least significant bytes of a 32-byte data value **/
private func readRightBytesN(_ data: Data, withSchema schema: ABI.Schema, bytes: Int) throws -> Data {
    try checkDataSize(data, words: 1, forSchema: schema)
    guard BigUInt(data.prefix(32 - bytes)) == .zero else {
        throw ABI.DecodeError.nonEmptyDataFound(schema, Hex(data))
    }
    return data.suffix(bytes)
}

/**
 *  Simply converts something that looks like an array type into something that looks like a tuple-type, e.g.
 *  for decoding. That is, a `.array(.uint8, 2)` decodes the same as a `.tuple2(.uint8, .uint8)`, so we literally
 *  construct that and decode to it. **/
private func arraySchemas(_ schema: ABI.Schema, _ n: Int) -> [ABI.Schema] {
    (1 ... n).map { _ in schema }
}

extension ABI.DecodeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .insufficientData(schema, hex):
            return NSLocalizedString("Insufficent data to decode value \(schema.description), given data \"\(hex.hex)\".", comment: "Insufficient Data Error")
        case let .excessData(schema, hex):
            return NSLocalizedString("Excess data found when decoding value \(schema.description), given data \"\(hex.hex)\".", comment: "Excess Data Error")
        case let .nonEmptyDataFound(schema, hex):
            return NSLocalizedString("Non-empty data found where expected empty when decoding value \(schema.description), given data \"\(hex.hex)\".", comment: "Non-Empty Data Error")
        case let .integerOverflow(schema, hex):
            return NSLocalizedString("Integer overflow when decoding type \(schema.description) with data \"\(hex.hex)\".", comment: "Integer Overflow Error")
        case let .sizedUnsignedIntegerOverflow(size, hex):
            return NSLocalizedString("Overflowed integer type \"\(hex.hex)\" cannot fit into uint\(size).", comment: "Sized Unsigned Integer Overflow Error")
        case let .sizedSignedIntegerOverflow(size, hex):
            return NSLocalizedString("Overflowed signed integer type \"\(hex.hex)\" cannot fit into int\(size).", comment: "Sized Signed Integer Overflow Error")
        case let .invalidDataPointer(schema, hex):
            return NSLocalizedString("Invalid data pointer for \(schema.description) with data \"\(hex.hex)\".", comment: "Invalid Data Pointer Error")
        case let .invalidDataHeapPointer(schema, heapStart, heapEnd, hex):
            return NSLocalizedString("Invalid data heap pointer for \(schema.description) tries to read data at \(heapStart != nil ? String(heapStart!) : "nil")..<\(heapEnd) in data \"\(hex.hex)\".", comment: "Invalid Data Heap Pointer Error")
        case let .invalidUtf8String(hex):
            return NSLocalizedString("Invalid utf8-encoded string with data \"\(hex)\".", comment: "Invalid UTF8 String Error")
        case let .invalidAddress(hex):
            return NSLocalizedString("Invalid address with data \"\(hex)\".", comment: "Invalid Address")
        case let .mismatchedType(schema, expSchema):
            return NSLocalizedString("Invalid value \(schema.description), expected to match \(expSchema.description).", comment: "Mismatched Type")
        case .invalidResponse:
            return NSLocalizedString("Invalid response or mismatch types when decoding.", comment: "Invalid Response")
        case let .unexpectedError(message):
            return String(format: NSLocalizedString("An unexpected error occurred: %@", comment: "Unexpected Error"), message)
        }
    }
}
