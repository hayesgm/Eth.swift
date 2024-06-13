import Foundation
import SwiftKeccak

public extension ABI {
    /// Errors which occur when attempting to encode or decode a event's ABI value.
    enum EventError: Error, Equatable {
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

    typealias SchemaIndex = (ABI.Schema, Bool)

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
    struct Event: Equatable, CustomStringConvertible {
        public let name: String
        public let indexedParam0: Schema?
        public let indexedParam1: Schema?
        public let indexedParam2: Schema?
        public let indexedParam3: Schema?
        public let parameters: Schema

        /// Initializes a new `ABI.Event`.
        /// - Parameters:
        ///   - name: The name of the function.
        ///   - parameters: The parameter schema types for the function.
        public init(name: String, parameters: [SchemaIndex]) {
            self.name = name
            self.parameters = parameters
            // TODO: Ensure that there are no more than 4 indexed topics
        }

        /// The all parameters of an event, as an array.
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).allParameters
        /// [.address,.string,.uint8]
        /// ```
        public var allParameters: ABI.Schema {
            parameters.map { $0.0 }
        }

        /// The indexed parameters of an event, as an array.
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).indexedParameters
        /// [.address]
        /// ```
        public var indexedParameters: ABI.Schema {
            parameters.filter { $0.1 }.map { $0.0 }
        }

        /// The non-indexed parameters of an event, as an array.
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).nonIndexedParameters
        /// [.string, .uint8]
        /// ```
        public var nonIndexedParameters: ABI.Schema {
            parameters.filter { $0.1 == false }.map { $0.0 }
        }

        /// Represents the non-indexed parameters schema types as a tuple (which is how they are encoded as non-indexed data)
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).dataTuple
        /// .tuple([.string, .uint8])
        /// ```
        public var dataTuple: ABI.Schema {
            .tuple(nonIndexedParameters)
        }

        /// The ABI topic of the event, e.g. `Cool(address,string,uint8)`
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).topic
        /// "Cool(address,string,uint8)"
        /// ```
        public var topic: String {
            "\(name)\(.tuple(allParameters).canonical)"
        }

        /// A description of the function, mirroring its topic.
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).description
        /// "Cool(address,string,uint8)"
        /// ```
        public var description: String {
            topic
        }

        /// The 32-byte topic hash of the event.
        ///
        /// See [OpenChain Signature Database](https://openchain.xyz/signatures) for decoding common examples.
        ///
        /// Note: will panic if the topic is unable to be encoded in UTF-8, e.g. due to the `name` string.
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: []).topicHash
        /// Hex("0x006214a8026d8fa96f4ce5e9ebf1ee58c5e12fe74120364c18e9743a18545d3a")
        /// ```
        public var topicHash: Hex {
            Hex(SwiftKeccak.keccak256(topic.data(using: .utf8)!))
        }

        /// ABI encodes the event with the given values.
        ///
        /// Examples
        /// ```
        /// > ABI.Event(name: "Cool", inputs: [(.address, true), (.string, false), (.uint8, false)], outputs: [])
        /// > .encode(with: [
        /// >   .address()
        /// >   .string("hello")
        /// >   .uint8(22)
        /// > ])
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
