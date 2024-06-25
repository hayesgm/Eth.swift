import BigInt
import Eth
import Foundation

enum Cool {
    static let creationCode: Hex = "0x608060405234801561001057600080fd5b5061017f806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80631c809c8b1461003b578063cad0899b14610063575b600080fd5b61004e6100493660046100ed565b610084565b60405190151581526020015b60405180910390f35b610076610071366004610106565b6100d8565b60405190815260200161005a565b60006064821061009657506001919050565b60328210156100b85760405163f288492560e01b815260040160405180910390fd5b604051634b45e72760e01b81526001600482015260240160405180910390fd5b60006100e48284610128565b90505b92915050565b6000602082840312156100ff57600080fd5b5035919050565b6000806040838503121561011957600080fd5b50508035926020909101359150565b808201808211156100e757634e487b7160e01b600052601160045260246000fdfea2646970667358221220074664322626b405f6104f84adbee9f6e5bda9a4f6ee28e58ee409c2fd99efc464736f6c63430008180033"
    static let runtimeCode: Hex = "0x608060405234801561001057600080fd5b50600436106100365760003560e01c80631c809c8b1461003b578063cad0899b14610063575b600080fd5b61004e6100493660046100ed565b610084565b60405190151581526020015b60405180910390f35b610076610071366004610106565b6100d8565b60405190815260200161005a565b60006064821061009657506001919050565b60328210156100b85760405163f288492560e01b815260040160405180910390fd5b604051634b45e72760e01b81526001600482015260240160405180910390fd5b60006100e48284610128565b90505b92915050565b6000602082840312156100ff57600080fd5b5035919050565b6000806040838503121561011957600080fd5b50508035926020909101359150565b808201808211156100e757634e487b7160e01b600052601160045260246000fdfea2646970667358221220074664322626b405f6104f84adbee9f6e5bda9a4f6ee28e58ee409c2fd99efc464736f6c63430008180033"

    static let LukeWarmError = ABI.Function(
        name: "LukeWarm",
        inputs: [.bool]
    )

    static let TooCoolError = ABI.Function(
        name: "TooCool",
        inputs: []
    )

    enum RevertReason: Equatable, Error {
        case lukeWarm(Bool)
        case tooCool
        case unknownRevert(String, String)
    }

    static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (LukeWarmError, let .tuple1(.bool(var0))):
            return .lukeWarm(var0)
        case (TooCoolError, _):
            return .tooCool
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
        }
    }

    static let errors: [ABI.Function] = [LukeWarmError, TooCoolError]
    static let sumFn = ABI.Function(
        name: "sum",
        inputs: [.uint256, .uint256],
        outputs: [.uint256]
    )

    static func sum(x: BigUInt, y: BigUInt) throws -> Result<BigUInt, RevertReason> {
        do {
            let query = try sumFn.encoded(with: [.uint256(x), .uint256(y)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
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

    static let vibeCheckFn = ABI.Function(
        name: "vibeCheck",
        inputs: [.uint256],
        outputs: [.bool]
    )

    static func vibeCheck(status: BigUInt) throws -> Result<Bool, RevertReason> {
        do {
            let query = try vibeCheckFn.encoded(with: [.uint256(status)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
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
}
