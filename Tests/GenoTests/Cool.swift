@preconcurrency import Eth
import Foundation

// Generated from swift run Geno ./Tests/Solidity/out/Cool.sol/Cool.json --outDir Tests/GenoTests
@preconcurrency import SwiftNumber

public enum Cool {
    public static let creationCode: Hex = "0x6080604052348015600e575f5ffd5b506102ce8061001c5f395ff3fe608060405234801561000f575f5ffd5b5060043610610034575f3560e01c80631c809c8b14610038578063cad0899b14610068575b5f5ffd5b610052600480360381019061004d9190610174565b610098565b60405161005f91906101b9565b60405180910390f35b610082600480360381019061007d91906101d2565b610128565b60405161008f919061021f565b60405180910390f35b5f606482106100aa5760019050610123565b60328210156100e5576040517ff288492500000000000000000000000000000000000000000000000000000000815260040160405180910390fd5b60016040517f4b45e72700000000000000000000000000000000000000000000000000000000815260040161011a91906101b9565b60405180910390fd5b919050565b5f81836101359190610265565b905092915050565b5f5ffd5b5f819050919050565b61015381610141565b811461015d575f5ffd5b50565b5f8135905061016e8161014a565b92915050565b5f602082840312156101895761018861013d565b5b5f61019684828501610160565b91505092915050565b5f8115159050919050565b6101b38161019f565b82525050565b5f6020820190506101cc5f8301846101aa565b92915050565b5f5f604083850312156101e8576101e761013d565b5b5f6101f585828601610160565b925050602061020685828601610160565b9150509250929050565b61021981610141565b82525050565b5f6020820190506102325f830184610210565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61026f82610141565b915061027a83610141565b925082820190508082111561029257610291610238565b5b9291505056fea264697066735822122015a0d6e77f4609a04ca3cdda883f68e623646144a5d1d17a731b6f578ce0278564736f6c634300081c0033"
    public static let runtimeCode: Hex = "0x608060405234801561000f575f5ffd5b5060043610610034575f3560e01c80631c809c8b14610038578063cad0899b14610068575b5f5ffd5b610052600480360381019061004d9190610174565b610098565b60405161005f91906101b9565b60405180910390f35b610082600480360381019061007d91906101d2565b610128565b60405161008f919061021f565b60405180910390f35b5f606482106100aa5760019050610123565b60328210156100e5576040517ff288492500000000000000000000000000000000000000000000000000000000815260040160405180910390fd5b60016040517f4b45e72700000000000000000000000000000000000000000000000000000000815260040161011a91906101b9565b60405180910390fd5b919050565b5f81836101359190610265565b905092915050565b5f5ffd5b5f819050919050565b61015381610141565b811461015d575f5ffd5b50565b5f8135905061016e8161014a565b92915050565b5f602082840312156101895761018861013d565b5b5f61019684828501610160565b91505092915050565b5f8115159050919050565b6101b38161019f565b82525050565b5f6020820190506101cc5f8301846101aa565b92915050565b5f5f604083850312156101e8576101e761013d565b5b5f6101f585828601610160565b925050602061020685828601610160565b9150509250929050565b61021981610141565b82525050565b5f6020820190506102325f830184610210565b92915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f61026f82610141565b915061027a83610141565b925082820190508082111561029257610291610238565b5b9291505056fea264697066735822122015a0d6e77f4609a04ca3cdda883f68e623646144a5d1d17a731b6f578ce0278564736f6c634300081c0033"

    public static let LukeWarmError = ABI.Function(
        name: "LukeWarm",
        inputs: [.bool]
    )

    public static let TooCoolError = ABI.Function(
        name: "TooCool",
        inputs: []
    )

    public enum RevertReason: Equatable, Error {
        case lukeWarm(Bool)
        case tooCool
        case unknownRevert(String, String)
    }

    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (LukeWarmError, let .tuple1(.bool(var0))):
            return .lukeWarm(var0)
        case (TooCoolError, _):
            return .tooCool
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
        }
    }

    public static let errors: [ABI.Function] = [LukeWarmError, TooCoolError]
    public static let functions: [ABI.Function] = [sumFn, vibeCheckFn]
    public static let sumFn = ABI.Function(
        name: "sum",
        inputs: [.uint256, .uint256],
        outputs: [.uint256]
    )

    public static func sum(x: Number, y: Number, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Number, RevertReason> {
        do {
            let query = try sumFn.encoded(with: [.uint256(x), .uint256(y)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try sumFn.decode(output: result)

            switch decoded {
            case let .tuple1(.uint256(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, sumFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func sumDecode(input: Hex) throws -> (Number, Number) {
        let decodedInput = try sumFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.uint256(x), .uint256(y)):
            return (x, y)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, sumFn.inputTuple)
        }
    }

    public static let vibeCheckFn = ABI.Function(
        name: "vibeCheck",
        inputs: [.uint256],
        outputs: [.bool]
    )

    public static func vibeCheck(status: Number, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Bool, RevertReason> {
        do {
            let query = try vibeCheckFn.encoded(with: [.uint256(status)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try vibeCheckFn.decode(output: result)

            switch decoded {
            case let .tuple1(.bool(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, vibeCheckFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func vibeCheckDecode(input: Hex) throws -> (Number) {
        let decodedInput = try vibeCheckFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.uint256(status)):
            return status
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, vibeCheckFn.inputTuple)
        }
    }
}
