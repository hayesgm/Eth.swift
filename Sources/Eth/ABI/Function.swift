import Foundation
import SwiftKeccak

public extension ABI {
    /// Errors that can occur when working with ABI functions.
    enum FunctionError: Error, Equatable {
        /// Error indicating that the function input is invalid.
        /// - Parameters:
        ///   - expected: The expected input schema.
        ///   - received: The received input schema.
        case invalidFunctionInput(ABI.Schema, ABI.Schema)

        /// Error indicating that the function output is invalid.
        /// - Parameters:
        ///   - expected: The expected output schema.
        ///   - received: The received output schema.
        case invalidFunctionOutput(ABI.Schema, ABI.Schema)

        /// A general error with a message.
        /// - Parameter message: The error message.
        case unexpectedError(String)
    }

    /// Represents an ABI function with a name, input schemas, and output schemas.
    struct Function: Equatable, CustomStringConvertible {
        let name: String
        let inputs: [ABI.Schema]
        let outputs: [ABI.Schema]

        /// Initializes a new `Function`.
        /// - Parameters:
        ///   - name: The name of the function.
        ///   - inputs: The input schemas for the function.
        ///   - outputs: The output schemas for the function.
        public init(name: String, inputs: [ABI.Schema], outputs: [ABI.Schema]) {
            self.name = name
            self.inputs = inputs
            self.outputs = outputs
        }

        var inputTuple: ABI.Schema {
            .tuple(inputs)
        }

        var outputTuple: ABI.Schema {
            .tuple(inputs)
        }

        /// The signature of the function.
        public var signature: String {
            "\(name)\(inputTuple.canonical)"
        }

        /// A description of the function, which is its signature.
        public var description: String {
            signature
        }

        /// The hash of the function's signature.
        public var signatureHash: Data {
            // TODO: handle unwraps !!
            SwiftKeccak.keccak256(signature.data(using: .utf8)!).subdata(in: 0 ..< 4)
        }

        /// Encodes the function with the provided fields.
        /// - Parameter fields: The fields to encode.
        /// - Throws: `FunctionError.invalidFunctionInput` if the field types do not match the input tuple.
        /// - Returns: The encoded data.
        public func encoded(with fields: [Field]) throws -> Data {
            let fieldTuple = Field.tupleN(fields)
            guard fieldTuple.fieldType == inputTuple else {
                throw FunctionError.invalidFunctionInput(fieldTuple.fieldType, inputTuple)
            }
            return signatureHash + fieldTuple.encoded
        }

        /// Decodes the function's output data.
        /// - Parameter data: The data to decode.
        /// - Throws: `FunctionError.invalidFunctionOutput` if the decoded field type does not match the output tuple.
        /// - Returns: The decoded field.
        public func decode(output data: Data) throws -> Field {
            let res = try outputTuple.decode(data)
            guard res.fieldType == outputTuple else {
                throw FunctionError.invalidFunctionOutput(res.fieldType, outputTuple)
            }
            return res
        }
    }
}
