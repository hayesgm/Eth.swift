import Foundation
import SwiftKeccak

public extension ABI {
    /// Errors which occur when attempting to encode or decode a function's ABI value.
    enum FunctionError: Error, Equatable {
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
    /// ```
    struct Function: Equatable, CustomStringConvertible {
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

        /// Represents the input schema types as a tuple (which is how they are encoded as parameters)
        public var inputTuple: ABI.Schema {
            .tuple(inputs)
        }

        /// Represents the outputs schema types as a tuple (which is how they are encoded as return values)
        public var outputTuple: ABI.Schema {
            .tuple(outputs)
        }

        /// The ABI signature of the function, e.g. `transfer(uint256,string)`
        public var signature: String {
            "\(name)\(inputTuple.canonical)"
        }

        /// A description of the function, mirroring its signature.
        public var description: String {
            signature
        }

        /// The four-byte signature hash of the function.
        /// See https://openchain.xyz/signatures for decoding common examples.
        public var signatureHash: Hex {
            // TODO: handle unwraps !!
            Hex(SwiftKeccak.keccak256(signature.data(using: .utf8)!).subdata(in: 0 ..< 4))
        }

        /// ABI encodes the function with the given values, which can then be `eth_call` or signed and submitted onchain.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [.uint8], outputs: []).encoded(with: [.uint8(22)])
        /// Hex("0xa8cb34810000000000000000000000000000000000000000000000000000000000000016")
        /// ```
        /// - Parameter values: The `Value`s to encode as input.
        /// - Throws: `FunctionError.invalidFunctionInput` if the `Value` schemas do not match the input tuple.
        /// - Returns: The encoded function call.
        public func encoded(with values: [Value]) throws -> Hex {
            let valueTuple = Value.tupleN(values)
            guard valueTuple.schema == inputTuple else {
                throw FunctionError.invalidFunctionInput(valueTuple.schema, inputTuple)
            }
            return Hex(signatureHash.data + valueTuple.encoded.data)
        }

        /// Decodes the output of the result of a function call.
        ///
        /// Examples
        /// ```
        /// > ABI.Function(name: "cool", inputs: [], outputs: [.uint8]).decode(output: "0000000000000000000000000000000000000000000000000000000000000016")
        /// ABI.Value.tuple1(.uint8(22))
        /// ```
        /// - Parameter hex: The hex result to decode.
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
