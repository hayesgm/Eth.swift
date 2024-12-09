// Generated from swift run Geno ./Tests/Solidity/out/Abi.sol/Abi.json --outDir Tests/GenoTests
@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum Abi {
    public static let creationCode: Hex = "0x6080604052348015600f57600080fd5b506102cf8061001f6000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c806359bf447a14610046578063866a37e41461006f578063a2f2ec4614610082575b600080fd5b610059610054366004610139565b610095565b60405161006691906101b7565b60405180910390f35b61005961007d366004610139565b6100c4565b610059610090366004610205565b6100db565b60608383836040516020016100ac9392919061021e565b60405160208183030381529060405290509392505050565b60608383836040516020016100ac93929190610238565b6060635179762360e11b6100ef838061026e565b60405160240161010191815260200190565b60408051601f198184030181529190526020810180516001600160e01b03166001600160e01b03199093169290921790915292915050565b60008060006040848603121561014e57600080fd5b83359250602084013567ffffffffffffffff81111561016c57600080fd5b8401601f8101861361017d57600080fd5b803567ffffffffffffffff81111561019457600080fd5b8660208284010111156101a657600080fd5b939660209190910195509293505050565b602081526000825180602084015260005b818110156101e557602081860181015160408684010152016101c8565b506000604082850101526040601f19601f83011684010191505092915050565b60006020828403121561021757600080fd5b5035919050565b838152818360208301376000910160200190815292915050565b83815260406020820152816040820152818360608301376000818301606090810191909152601f909201601f1916010192915050565b808202811582820484141761029357634e487b7160e01b600052601160045260246000fd5b9291505056fea2646970667358221220f40de20c76bf6158905a2b2d66fc8558456b772cb8e3e624a5b5ee07ade79df064736f6c634300081b0033"
    public static let runtimeCode: Hex = "0x608060405234801561001057600080fd5b50600436106100415760003560e01c806359bf447a14610046578063866a37e41461006f578063a2f2ec4614610082575b600080fd5b610059610054366004610139565b610095565b60405161006691906101b7565b60405180910390f35b61005961007d366004610139565b6100c4565b610059610090366004610205565b6100db565b60608383836040516020016100ac9392919061021e565b60405160208183030381529060405290509392505050565b60608383836040516020016100ac93929190610238565b6060635179762360e11b6100ef838061026e565b60405160240161010191815260200190565b60408051601f198184030181529190526020810180516001600160e01b03166001600160e01b03199093169290921790915292915050565b60008060006040848603121561014e57600080fd5b83359250602084013567ffffffffffffffff81111561016c57600080fd5b8401601f8101861361017d57600080fd5b803567ffffffffffffffff81111561019457600080fd5b8660208284010111156101a657600080fd5b939660209190910195509293505050565b602081526000825180602084015260005b818110156101e557602081860181015160408684010152016101c8565b506000604082850101526040601f19601f83011684010191505092915050565b60006020828403121561021757600080fd5b5035919050565b838152818360208301376000910160200190815292915050565b83815260406020820152816040820152818360608301376000818301606090810191909152601f909201601f1916010192915050565b808202811582820484141761029357634e487b7160e01b600052601160045260246000fd5b9291505056fea2646970667358221220f40de20c76bf6158905a2b2d66fc8558456b772cb8e3e624a5b5ee07ade79df064736f6c634300081b0033"

    public enum RevertReason: Equatable, Error {
        case unknownRevert(String, String)
    }

    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
        }
    }

    public static let errors: [ABI.Function] = []
    public static let functions: [ABI.Function] = [abiEncodeSelectorFn, simpleAbiEncodingFn, simpleAbiEncodingPackedFn]
    public static let abiEncodeSelectorFn = ABI.Function(
        name: "abiEncodeSelector",
        inputs: [.uint256],
        outputs: [.bytes]
    )

    public static func abiEncodeSelector(x: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Hex, RevertReason> {
        do {
            let query = try abiEncodeSelectorFn.encoded(with: [.uint256(x)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try abiEncodeSelectorFn.decode(output: result)

            switch decoded {
            case let .tuple1(.bytes(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, abiEncodeSelectorFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func abiEncodeSelectorDecode(input: Hex) throws -> (BigUInt) {
        let decodedInput = try abiEncodeSelectorFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.uint256(x)):
            return x
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, abiEncodeSelectorFn.inputTuple)
        }
    }

    public static let simpleAbiEncodingFn = ABI.Function(
        name: "simpleAbiEncoding",
        inputs: [.uint256, .string],
        outputs: [.bytes]
    )

    public static func simpleAbiEncoding(x: BigUInt, y: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Hex, RevertReason> {
        do {
            let query = try simpleAbiEncodingFn.encoded(with: [.uint256(x), .string(y)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try simpleAbiEncodingFn.decode(output: result)

            switch decoded {
            case let .tuple1(.bytes(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, simpleAbiEncodingFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func simpleAbiEncodingDecode(input: Hex) throws -> (BigUInt, String) {
        let decodedInput = try simpleAbiEncodingFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.uint256(x), .string(y)):
            return (x, y)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, simpleAbiEncodingFn.inputTuple)
        }
    }

    public static let simpleAbiEncodingPackedFn = ABI.Function(
        name: "simpleAbiEncodingPacked",
        inputs: [.uint256, .string],
        outputs: [.bytes]
    )

    public static func simpleAbiEncodingPacked(x: BigUInt, y: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Hex, RevertReason> {
        do {
            let query = try simpleAbiEncodingPackedFn.encoded(with: [.uint256(x), .string(y)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try simpleAbiEncodingPackedFn.decode(output: result)

            switch decoded {
            case let .tuple1(.bytes(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, simpleAbiEncodingPackedFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func simpleAbiEncodingPackedDecode(input: Hex) throws -> (BigUInt, String) {
        let decodedInput = try simpleAbiEncodingPackedFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.uint256(x), .string(y)):
            return (x, y)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, simpleAbiEncodingPackedFn.inputTuple)
        }
    }
}
