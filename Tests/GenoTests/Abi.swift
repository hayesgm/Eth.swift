@preconcurrency import Eth
import Foundation

// Generated from swift run Geno ./Tests/Solidity/out/Abi.sol/Abi.json --outDir Tests/GenoTests
@preconcurrency import SwiftNumber

public enum Abi {
    public static let creationCode: Hex = "0x6080604052348015600e575f5ffd5b5061052c8061001c5f395ff3fe608060405234801561000f575f5ffd5b506004361061003f575f3560e01c806359bf447a14610043578063866a37e414610073578063a2f2ec46146100a3575b5f5ffd5b61005d60048036038101906100589190610257565b6100d3565b60405161006a9190610324565b60405180910390f35b61008d60048036038101906100889190610257565b610102565b60405161009a9190610324565b60405180910390f35b6100bd60048036038101906100b89190610344565b610131565b6040516100ca9190610324565b60405180910390f35b60608383836040516020016100ea939291906103cb565b60405160208183030381529060405290509392505050565b60608383836040516020016101199392919061043f565b60405160208183030381529060405290509392505050565b606063a2f2ec4660e01b8283610147919061049c565b60405160240161015791906104dd565b604051602081830303815290604052907bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff83818316178352505050509050919050565b5f5ffd5b5f5ffd5b5f819050919050565b6101d5816101c3565b81146101df575f5ffd5b50565b5f813590506101f0816101cc565b92915050565b5f5ffd5b5f5ffd5b5f5ffd5b5f5f83601f840112610217576102166101f6565b5b8235905067ffffffffffffffff811115610234576102336101fa565b5b6020830191508360018202830111156102505761024f6101fe565b5b9250929050565b5f5f5f6040848603121561026e5761026d6101bb565b5b5f61027b868287016101e2565b935050602084013567ffffffffffffffff81111561029c5761029b6101bf565b5b6102a886828701610202565b92509250509250925092565b5f81519050919050565b5f82825260208201905092915050565b8281835e5f83830152505050565b5f601f19601f8301169050919050565b5f6102f6826102b4565b61030081856102be565b93506103108185602086016102ce565b610319816102dc565b840191505092915050565b5f6020820190508181035f83015261033c81846102ec565b905092915050565b5f60208284031215610359576103586101bb565b5b5f610366848285016101e2565b91505092915050565b5f819050919050565b610389610384826101c3565b61036f565b82525050565b5f81905092915050565b828183375f83830152505050565b5f6103b2838561038f565b93506103bf838584610399565b82840190509392505050565b5f6103d68286610378565b6020820191506103e78284866103a7565b9150819050949350505050565b6103fd816101c3565b82525050565b5f82825260208201905092915050565b5f61041e8385610403565b935061042b838584610399565b610434836102dc565b840190509392505050565b5f6040820190506104525f8301866103f4565b8181036020830152610465818486610413565b9050949350505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f6104a6826101c3565b91506104b1836101c3565b92508282026104bf816101c3565b915082820484148315176104d6576104d561046f565b5b5092915050565b5f6020820190506104f05f8301846103f4565b9291505056fea26469706673582212202de7ff6679e9c8a540ef121d0ded8e217baf47f91e83954b19bd8bb534e8823c64736f6c634300081c0033"
    public static let runtimeCode: Hex = "0x608060405234801561000f575f5ffd5b506004361061003f575f3560e01c806359bf447a14610043578063866a37e414610073578063a2f2ec46146100a3575b5f5ffd5b61005d60048036038101906100589190610257565b6100d3565b60405161006a9190610324565b60405180910390f35b61008d60048036038101906100889190610257565b610102565b60405161009a9190610324565b60405180910390f35b6100bd60048036038101906100b89190610344565b610131565b6040516100ca9190610324565b60405180910390f35b60608383836040516020016100ea939291906103cb565b60405160208183030381529060405290509392505050565b60608383836040516020016101199392919061043f565b60405160208183030381529060405290509392505050565b606063a2f2ec4660e01b8283610147919061049c565b60405160240161015791906104dd565b604051602081830303815290604052907bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff83818316178352505050509050919050565b5f5ffd5b5f5ffd5b5f819050919050565b6101d5816101c3565b81146101df575f5ffd5b50565b5f813590506101f0816101cc565b92915050565b5f5ffd5b5f5ffd5b5f5ffd5b5f5f83601f840112610217576102166101f6565b5b8235905067ffffffffffffffff811115610234576102336101fa565b5b6020830191508360018202830111156102505761024f6101fe565b5b9250929050565b5f5f5f6040848603121561026e5761026d6101bb565b5b5f61027b868287016101e2565b935050602084013567ffffffffffffffff81111561029c5761029b6101bf565b5b6102a886828701610202565b92509250509250925092565b5f81519050919050565b5f82825260208201905092915050565b8281835e5f83830152505050565b5f601f19601f8301169050919050565b5f6102f6826102b4565b61030081856102be565b93506103108185602086016102ce565b610319816102dc565b840191505092915050565b5f6020820190508181035f83015261033c81846102ec565b905092915050565b5f60208284031215610359576103586101bb565b5b5f610366848285016101e2565b91505092915050565b5f819050919050565b610389610384826101c3565b61036f565b82525050565b5f81905092915050565b828183375f83830152505050565b5f6103b2838561038f565b93506103bf838584610399565b82840190509392505050565b5f6103d68286610378565b6020820191506103e78284866103a7565b9150819050949350505050565b6103fd816101c3565b82525050565b5f82825260208201905092915050565b5f61041e8385610403565b935061042b838584610399565b610434836102dc565b840190509392505050565b5f6040820190506104525f8301866103f4565b8181036020830152610465818486610413565b9050949350505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f6104a6826101c3565b91506104b1836101c3565b92508282026104bf816101c3565b915082820484148315176104d6576104d561046f565b5b5092915050565b5f6020820190506104f05f8301846103f4565b9291505056fea26469706673582212202de7ff6679e9c8a540ef121d0ded8e217baf47f91e83954b19bd8bb534e8823c64736f6c634300081c0033"

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

    public static func abiEncodeSelector(x: Number, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Hex, RevertReason> {
        do {
            let query = try abiEncodeSelectorFn.encoded(with: [.uint256(x)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func abiEncodeSelectorDecode(input: Hex) throws -> (Number) {
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

    public static func simpleAbiEncoding(x: Number, y: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Hex, RevertReason> {
        do {
            let query = try simpleAbiEncodingFn.encoded(with: [.uint256(x), .string(y)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func simpleAbiEncodingDecode(input: Hex) throws -> (Number, String) {
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

    public static func simpleAbiEncodingPacked(x: Number, y: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Hex, RevertReason> {
        do {
            let query = try simpleAbiEncodingPackedFn.encoded(with: [.uint256(x), .string(y)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func simpleAbiEncodingPackedDecode(input: Hex) throws -> (Number, String) {
        let decodedInput = try simpleAbiEncodingPackedFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.uint256(x), .string(y)):
            return (x, y)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, simpleAbiEncodingPackedFn.inputTuple)
        }
    }
}
