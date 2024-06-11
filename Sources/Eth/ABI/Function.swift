import Foundation
import SwiftKeccak

public extension ABI {
    enum FunctionError: Error, Equatable {
        case invalidFunctionInput(ABI.Schema, ABI.Schema)
        case invalidFunctionOutput(ABI.Schema, ABI.Schema)
        case unexpectedError(String)
    }

    struct Function: Equatable, CustomStringConvertible {
        let name: String
        let inputs: [ABI.Schema]
        let outputs: [ABI.Schema]

        public init(name: String, inputs: [ABI.Schema], outputs: [ABI.Schema]) {
            self.name = name
            self.inputs = inputs
            self.outputs = outputs
        }

        var inputTuple: ABI.Schema {
            .tuple(inputs)
        }

        var outputTuple: ABI.Schema {
            .tuple(outputs)
        }

        public var signature: String {
            "\(name)\(inputTuple.canonical)"
        }

        public var description: String {
            signature
        }

        public var signatureHash: Data {
            // TODO: handle unwraps !!
            SwiftKeccak.keccak256(signature.data(using: .utf8)!).subdata(in: 0 ..< 4)
        }

        public func encoded(with fields: [Field]) throws -> Data {
            let fieldTuple = Field.tupleN(fields)
            guard fieldTuple.fieldType == inputTuple else {
                throw FunctionError.invalidFunctionInput(fieldTuple.fieldType, inputTuple)
            }
            return signatureHash + fieldTuple.encoded
        }

        public func decode(output data: Data) throws -> Field {
            let res = try outputTuple.decode(data)
            guard res.fieldType == outputTuple else {
                throw FunctionError.invalidFunctionOutput(res.fieldType, outputTuple)
            }
            return res
        }
    }
}
