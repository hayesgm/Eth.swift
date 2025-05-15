import Foundation
import SwiftKeccak

public extension ABI {
    /// Errors which occur when attempting to encode or decode a function's ABI value.
    enum FunctionError: Error, Equatable {
        /// Error indicating a function's 4-byte ABI signature does not match this function's own signature.
        /// This is for decoding function inputs and means the data does not match this function.
        /// - Parameters:
        ///   - expected: The expected 4-byte ABI signature.
        ///   - received: The received signature if input data was at least 4 bytes, otherwise the empty hex.
        case mismatchedAbiSignature(Hex, Hex)

        /// Error indicating that the function input does not properly match the function's input schema.
        /// This is usually an issue with code generation choosing the wrong schema types.
        /// - Parameters:
        ///   - expected: The expected input schema.
        ///   - received: The received input schema.
        case invalidFunctionInput(ABI.Schema, ABI.Schema)

        /// Error indicating that the function output does not properly match the function's output schema.
        /// E.g. received a `.tuple1(.string)` when expecting a `.tuple1(.uint256)`.
        /// This is usually an issue with code generation choosing the wrong schema types.
        /// - Parameters:
        ///   - expected: The expected output schema.
        ///   - received: The received output schema.
        case invalidFunctionOutput(ABI.Schema, ABI.Schema)

        /// An unexpected error occurred. This is reserved for codepaths we never expect to encounter.
        /// - Parameter message: The error message.
        case unexpectedError(String)
    }

    /// Represents an Solidity ABI function including the function name, its input schema type and output schema type.
    ///
    /// Example Usage
    /// ```
    /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.uint8(22)])
    /// Hex("0xa8cb34810000000000000000000000000000000000000000000000000000000000000016")
    ///
    /// > ABI.Function(name: "cool", inputs: [], outputs: [.uint8]).decode(output: "0000000000000000000000000000000000000000000000000000000000000016")
    /// ABI.Value.tuple1(.uint8(22))
    ///
    /// > ABI.Function(name: "myError", inputs: [.uint8]).decodeInput(input: Hex("0x10ff10dd0000000000000000000000000000000000000000000000000000000000000016"))
    /// ABI.Value.tuple1(.uint8(22))
    /// ```
    struct Function: Equatable, CustomStringConvertible, Sendable {
        public let name: String
        public let inputs: [ABI.Schema]
        public let outputs: [ABI.Schema]

        /// Initializes a new `ABI.Function`.
        /// - Parameters:
        ///   - name: The name of the function.
        ///   - inputs: The input schema types for the function.
        ///   - outputs: The output schema types for the function.
        public init(name: String, inputs: [ABI.Schema], outputs: [ABI.Schema]) {
            self.name = name
            self.inputs = inputs
            self.outputs = outputs
        }

        /// Initializes a new `ABI.Function` with an empty output.
        /// - Parameters:
        ///   - name: The name of the function.
        ///   - inputs: The input schema types for the function.
        public init(name: String, inputs: [ABI.Schema]) {
            self.name = name
            self.inputs = inputs
            outputs = []
        }

        /// Represents the input schema types as a tuple (which is how they are encoded as parameters)
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).inputTuple
        /// .tuple([.uint8])
        /// ```
        public var inputTuple: ABI.Schema {
            .tuple(inputs)
        }

        /// Represents the outputs schema types as a tuple (which is how they are encoded as return values)
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).outputTuple
        /// .tuple([])
        /// ```
        public var outputTuple: ABI.Schema {
            .tuple(outputs)
        }

        /// The ABI signature of the function, e.g. `transfer(uint256,string)`
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).signature
        /// "cool(uint8)"
        /// ```
        public var signature: String {
            "\(name)\(inputTuple.canonical)"
        }

        /// A description of the function, mirroring its signature.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).description
        /// "cool(uint8)"
        /// ```
        public var description: String {
            signature
        }

        /// The four-byte signature hash of the function.
        ///
        /// See [OpenChain Signature Database](https://openchain.xyz/signatures) for decoding common examples.
        ///
        /// Note: will panic if the signature is unable to be encoded in UTF-8, e.g. due to the `name` string.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).signatureHash
        /// Hex("0xa8cb3481")
        /// ```
        public var signatureHash: Hex {
            Hex(SwiftKeccak.keccak256(signature.data(using: .utf8)!).subdata(in: 0 ..< 4))
        }

        /// ABI encodes the function with the given values, which can then be `eth_call` or signed and submitted onchain.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.uint8(22)])
        /// Hex("0xa8cb34810000000000000000000000000000000000000000000000000000000000000016")
        ///
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.string("hello")])
        /// ABI.FunctionError.invalidFunctionInput(.tuple([.uint8]), .tuple([.string]))
        /// ```
        /// - Parameter values: The `Value`s to encode as input.
        /// - Throws: `FunctionError.invalidFunctionInput` if the `Value` schemas do not match the input tuple.
        /// - Returns: The encoded function call.
        public func encoded(with values: [Value]) throws -> Hex {
            let valueTuple = Value.tupleN(values)
            guard valueTuple.schema == inputTuple else {
                throw FunctionError.invalidFunctionInput(inputTuple, valueTuple.schema)
            }
            return Hex(signatureHash.data + valueTuple.encoded.data)
        }

        /// Decodes the input of a function call if the four-byte signature matches.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).decodeInput(input: "0xa8cb34810000000000000000000000000000000000000000000000000000000000000016")
        /// ABI.Value.tuple1(.uint8(22))
        ///
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).decodeInput(input: "0x0000000000000000000000000000000000000000000000000000000000000016", signatureIncluded: false)
        /// ABI.Value.tuple1(.uint8(22))
        ///
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).decodeInput(input: "0xffffffff0000000000000000000000000000000000000000000000000000000000000016")
        /// ABI.FunctionError.mismatchedAbiSignature("0x11223344", "0x55667788")
        /// ```
        /// - Parameter hex: The hex result to decode.
        /// - Parameter signatureIncluded: Whether the 4-byte ABI signature is included and should be matched.
        /// - Throws: `FunctionError.mismatchedAbiSignature` if the 4-byte ABI signature does not match
        /// - Throws: `ABI.DecodeError` on decoding errors.
        /// - Throws: `FunctionError.invalidFunctionInput` if the decoded `Value` schemas does not match the output tuple.
        /// - Returns: The decoded value of the function call, as a tuple.
        public func decodeInput(input hex: Hex, signatureIncluded: Bool = true) throws -> Value {
            let parameterHex: Hex
            if signatureIncluded {
                if hex.count < 4 {
                    throw FunctionError.mismatchedAbiSignature(signatureHash, .empty)
                } else {
                    let givenSignature = Hex(hex.data.subdata(in: 0 ..< 4))
                    if signatureHash == givenSignature {
                        parameterHex = Hex(Data(hex.data.dropFirst(4)))
                    } else {
                        throw FunctionError.mismatchedAbiSignature(signatureHash, givenSignature)
                    }
                }
            } else {
                parameterHex = hex
            }

            let res = try inputTuple.decode(parameterHex)
            guard res.schema == inputTuple else {
                throw FunctionError.invalidFunctionInput(res.schema, outputTuple)
            }
            return res
        }

        /// Decodes the output of the result of a function call.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [], outputs: [.uint8]).decode(output: "0x0000000000000000000000000000000000000000000000000000000000000016")
        /// ABI.Value.tuple1(.uint8(22))
        /// ```
        /// - Parameter hex: The hex result to decode.
        /// - Throws: `ABI.DecodeError` on decoding errors.
        /// - Throws: `FunctionError.invalidFunctionOutput` if the decoded `Value` schemas does not match the output tuple.
        /// - Returns: The decoded value of the function call, as a tuple.
        public func decode(output hex: Hex) throws -> Value {
            let res = try outputTuple.decode(hex)
            guard res.schema == outputTuple else {
                throw FunctionError.invalidFunctionOutput(res.schema, outputTuple)
            }
            return res
        }
    }
}
