@testable import Eth
import SwiftNumber
import XCTest

struct Cat: Equatable {
    static let schema: ABI.Schema = .tuple([.string, .uint8])
    let name: String
    let age: UInt

    var encoded: Hex {
        ABI.Value.tuple2(.string(name), .uint8(age)).encoded
    }

    static func decode(hex: Hex) throws -> Cat {
        let decoded = try schema.decode(hex)
        switch decoded {
        case let .tuple2(.string(name), .uint8(age)):
            return Cat(name: name, age: age)
        default:
            throw ABI.DecodeError.mismatchedType(decoded.schema, schema)
        }
    }
}

enum Drool {
    static let bytecode: Hex = "0x608060405234801561001057600080fd5b50600436106100625760003560e01c806345bd069b14610067578063543209b71461008c5780636401557d1461009f57806377d4c90b146100b2578063990c8f79146100c5578063c6162c61146100cc575b600080fd5b61007a610075366004610126565b6100df565b60405190815260200160405180910390f35b61007a61009a366004610126565b6100f2565b61007a6100ad366004610126565b6100ff565b61007a6100c0366004610126565b61010c565b603761007a565b61007a6100da366004610126565b610119565b60006100ec82603761016b565b92915050565b60006100ec82603761017f565b60006100ec826037610192565b60006100ec8260376101a5565b60006100ec8260376101d3565b60006020828403121561013857600080fd5b5035919050565b634e487b7160e01b600052601260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b60008261017a5761017a61013f565b500490565b808201808211156100ec576100ec610155565b818103818111156100ec576100ec610155565b6000826101b4576101b461013f565b600160ff1b8214600019841416156101ce576101ce610155565b500590565b80820281158282048414176100ec576100ec61015556fea26469706673582212205e0aca7c09fe2c25d34f673bbeb953b0e44deab893b994c2b07631517a39090364736f6c63430008180033"

    static let additionFn = ABI.Function(
        name: "addition",
        inputs: [.uint256],
        outputs: [.uint256]
    )

    static func additionEncode(x: Number) throws -> Hex {
        try additionFn.encoded(with: [.uint256(x)])
    }

    static func additionVmCall(x: Number, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Number {
        switch try additionFn.decode(output: await EVM.runQuery(bytecode: bytecode, query: additionEncode(x: x), withFunctions: ffis)) {
        case let .tuple1(.uint256(x)):
            return x
        default:
            throw ABI.FunctionError.unexpectedError("invalid decode")
        }
    }
}
