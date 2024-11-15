import BigInt
import Foundation

public enum IConsole {
    public static let creationCode: Hex = "0x"
    public static let runtimeCode: Hex = "0x"

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
    public static let functions: [ABI.Function] = [logFn, log1Fn, log2Fn, log3Fn, log4Fn, log5Fn, log6Fn, log7Fn, log8Fn, log9Fn, log10Fn, log11Fn, log12Fn, log13Fn, log14Fn, log15Fn, log16Fn, log17Fn, log18Fn, log19Fn, log20Fn, log21Fn, log22Fn, log23Fn, log24Fn, log25Fn, log26Fn, log27Fn, log28Fn, log29Fn, log30Fn, log31Fn, log32Fn, log33Fn, log34Fn, log35Fn, log36Fn, log37Fn, log38Fn, log39Fn, log40Fn, log41Fn, log42Fn, log43Fn, log44Fn, log45Fn, log46Fn, log47Fn, log48Fn, log49Fn, log50Fn, log51Fn, log52Fn, log53Fn, log54Fn, log55Fn, log56Fn, log57Fn, log58Fn, log59Fn, log60Fn, log61Fn, log62Fn, log63Fn, log64Fn, log65Fn, log66Fn, log67Fn, log68Fn, log69Fn, log70Fn, log71Fn, log72Fn, log73Fn, log74Fn, log75Fn, log76Fn, log77Fn, log78Fn, log79Fn, log80Fn, log81Fn, log82Fn, log83Fn, log84Fn, log85Fn, log86Fn, log87Fn, log88Fn, log89Fn, log90Fn, log91Fn, log92Fn, log93Fn, log94Fn, log95Fn, log96Fn, log97Fn, log98Fn, log99Fn, log100Fn, log101Fn, log102Fn, log103Fn, log104Fn, log105Fn, log106Fn, log107Fn, log108Fn, log109Fn, log110Fn, log111Fn, log112Fn, log113Fn, log114Fn, log115Fn, log116Fn, log117Fn, log118Fn, log119Fn, log120Fn, log121Fn, log122Fn, log123Fn, log124Fn, log125Fn, log126Fn, log127Fn, log128Fn, log129Fn, log130Fn, log131Fn, log132Fn, log133Fn, log134Fn, log135Fn, log136Fn, log137Fn, log138Fn, log139Fn, log140Fn, log141Fn, log142Fn, log143Fn, log144Fn, log145Fn, log146Fn, log147Fn, log148Fn, log149Fn, log150Fn, log151Fn, log152Fn, log153Fn, log154Fn, log155Fn, log156Fn, log157Fn, log158Fn, log159Fn, log160Fn, log161Fn, log162Fn, log163Fn, log164Fn, log165Fn, log166Fn, log167Fn, log168Fn, log169Fn, log170Fn, log171Fn, log172Fn, log173Fn, log174Fn, log175Fn, log176Fn, log177Fn, log178Fn, log179Fn, log180Fn, log181Fn, log182Fn, log183Fn, log184Fn, log185Fn, log186Fn, log187Fn, log188Fn, log189Fn, log190Fn, log191Fn, log192Fn, log193Fn, log194Fn, log195Fn, log196Fn, log197Fn, log198Fn, log199Fn, log200Fn, log201Fn, log202Fn, log203Fn, log204Fn, log205Fn, log206Fn, log207Fn, log208Fn, log209Fn, log210Fn, log211Fn, log212Fn, log213Fn, log214Fn, log215Fn, log216Fn, log217Fn, log218Fn, log219Fn, log220Fn, log221Fn, log222Fn, log223Fn, log224Fn, log225Fn, log226Fn, log227Fn, log228Fn, log229Fn, log230Fn, log231Fn, log232Fn, log233Fn, log234Fn, log235Fn, log236Fn, log237Fn, log238Fn, log239Fn, log240Fn, log241Fn, log242Fn, log243Fn, log244Fn, log245Fn, log246Fn, log247Fn, log248Fn, log249Fn, log250Fn, log251Fn, log252Fn, log253Fn, log254Fn, log255Fn, log256Fn, log257Fn, log258Fn, log259Fn, log260Fn, log261Fn, log262Fn, log263Fn, log264Fn, log265Fn, log266Fn, log267Fn, log268Fn, log269Fn, log270Fn, log271Fn, log272Fn, log273Fn, log274Fn, log275Fn, log276Fn, log277Fn, log278Fn, log279Fn, log280Fn, log281Fn, log282Fn, log283Fn, log284Fn, log285Fn, log286Fn, log287Fn, log288Fn, log289Fn, log290Fn, log291Fn, log292Fn, log293Fn, log294Fn, log295Fn, log296Fn, log297Fn, log298Fn, log299Fn, log300Fn, log301Fn, log302Fn, log303Fn, log304Fn, log305Fn, log306Fn, log307Fn, log308Fn, log309Fn, log310Fn, log311Fn, log312Fn, log313Fn, log314Fn, log315Fn, log316Fn, log317Fn, log318Fn, log319Fn, log320Fn, log321Fn, log322Fn, log323Fn, log324Fn, log325Fn, log326Fn, log327Fn, log328Fn, log329Fn, log330Fn, log331Fn, log332Fn, log333Fn, log334Fn, log335Fn, log336Fn, log337Fn, log338Fn, log339Fn, log340Fn, log341Fn, log342Fn, logAddressFn, logBoolFn, logBytesFn, logBytes1Fn, logBytes10Fn, logBytes11Fn, logBytes12Fn, logBytes13Fn, logBytes14Fn, logBytes15Fn, logBytes16Fn, logBytes17Fn, logBytes18Fn, logBytes19Fn, logBytes2Fn, logBytes20Fn, logBytes21Fn, logBytes22Fn, logBytes23Fn, logBytes24Fn, logBytes25Fn, logBytes26Fn, logBytes27Fn, logBytes28Fn, logBytes29Fn, logBytes3Fn, logBytes30Fn, logBytes31Fn, logBytes32Fn, logBytes4Fn, logBytes5Fn, logBytes6Fn, logBytes7Fn, logBytes8Fn, logBytes9Fn, logIntFn, logStringFn, logUintFn]
    public static let logFn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string],
        outputs: []
    )

    public static func log(p0: EthAddress, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logFn.encoded(with: [.address(p0), .address(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log1Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log1(p0: Bool, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log1Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log1Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log1Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log2Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address],
        outputs: []
    )

    public static func log2(p0: EthAddress, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log2Fn.encoded(with: [.address(p0), .address(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log2Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log2Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log3Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .string],
        outputs: []
    )

    public static func log3(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log3Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log3Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log3Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log4Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .string],
        outputs: []
    )

    public static func log4(p0: String, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log4Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log4Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log4Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log5Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .uint256],
        outputs: []
    )

    public static func log5(p0: BigUInt, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log5Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log5Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log5Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log6Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .uint256],
        outputs: []
    )

    public static func log6(p0: Bool, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log6Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log6Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log6Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log7Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address],
        outputs: []
    )

    public static func log7(p0: Bool, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log7Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log7Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log7Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log8Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .bool],
        outputs: []
    )

    public static func log8(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log8Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log8Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log8Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log9Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .string],
        outputs: []
    )

    public static func log9(p0: EthAddress, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log9Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log9Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log9Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log10Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log10(p0: Bool, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log10Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log10Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log10Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log11Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .uint256],
        outputs: []
    )

    public static func log11(p0: Bool, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log11Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log11Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log11Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log12Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log12(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log12Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log12Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log12Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log13Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256],
        outputs: []
    )

    public static func log13(p0: String, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log13Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log13Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log13Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log14Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .address],
        outputs: []
    )

    public static func log14(p0: EthAddress, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log14Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log14Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log14Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log15Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .bool],
        outputs: []
    )

    public static func log15(p0: EthAddress, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log15Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log15Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log15Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log16Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .bool],
        outputs: []
    )

    public static func log16(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log16Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log16Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log16Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log17Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .bool],
        outputs: []
    )

    public static func log17(p0: EthAddress, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log17Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log17Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log17Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log18Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log18(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log18Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log18Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log18Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log19Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .address],
        outputs: []
    )

    public static func log19(p0: String, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log19Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log19Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log19Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log20Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address],
        outputs: []
    )

    public static func log20(p0: Bool, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log20Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log20Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log20Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log21Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256],
        outputs: []
    )

    public static func log21(p0: Bool, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log21Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log21Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log21Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log22Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .string],
        outputs: []
    )

    public static func log22(p0: Bool, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log22Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log22Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log22Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log23Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256],
        outputs: []
    )

    public static func log23(p0: Bool, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log23Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log23Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log23Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log24Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .address],
        outputs: []
    )

    public static func log24(p0: Bool, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log24Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log24Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log24Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log25Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log25(p0: Bool, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log25Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log25Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log25Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log26Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .address],
        outputs: []
    )

    public static func log26(p0: Bool, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log26Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log26Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log26Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log27Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .uint256],
        outputs: []
    )

    public static func log27(p0: EthAddress, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log27Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log27Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log27Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log28Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .address],
        outputs: []
    )

    public static func log28(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log28Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log28Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log28Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log29Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .bool],
        outputs: []
    )

    public static func log29(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log29Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log29Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log29Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log30Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .uint256],
        outputs: []
    )

    public static func log30(p0: Bool, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log30Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log30Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log30Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log31Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .string],
        outputs: []
    )

    public static func log31(p0: Bool, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log31Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log31Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log31Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log32Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256],
        outputs: []
    )

    public static func log32(p0: EthAddress, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log32Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log32Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log32Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log33Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool],
        outputs: []
    )

    public static func log33(p0: Bool, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log33Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log33Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log33Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log34Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log34(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log34Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log34Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log34Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log35Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .address],
        outputs: []
    )

    public static func log35(p0: EthAddress, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log35Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log35Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log35Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log36Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .string],
        outputs: []
    )

    public static func log36(p0: Bool, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log36Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log36Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log36Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log37Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .string],
        outputs: []
    )

    public static func log37(p0: Bool, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log37Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log37Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log37Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log38Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .address],
        outputs: []
    )

    public static func log38(p0: Bool, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log38Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log38Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log38Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log39Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address],
        outputs: []
    )

    public static func log39(p0: String, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log39Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log39Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log39Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log40Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool],
        outputs: []
    )

    public static func log40(p0: BigUInt, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log40Fn.encoded(with: [.uint256(p0), .bool(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log40Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log40Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log41Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .address],
        outputs: []
    )

    public static func log41(p0: Bool, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log41Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log41Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log41Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log42Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .string],
        outputs: []
    )

    public static func log42(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log42Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log42Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log42Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log43Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log43(p0: EthAddress, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log43Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log43Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log43Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log44Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .bool],
        outputs: []
    )

    public static func log44(p0: Bool, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log44Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log44Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log44Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log45Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256],
        outputs: []
    )

    public static func log45(p0: BigUInt, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log45Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log45Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log45Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log46Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .address],
        outputs: []
    )

    public static func log46(p0: EthAddress, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log46Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log46Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log46Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log47Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool],
        outputs: []
    )

    public static func log47(p0: BigUInt, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log47Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log47Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log47Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log48Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log48(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log48Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log48Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log48Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log49Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string],
        outputs: []
    )

    public static func log49(p0: EthAddress, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log49Fn.encoded(with: [.address(p0), .bool(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log49Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log49Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log50Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .string],
        outputs: []
    )

    public static func log50(p0: BigUInt, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log50Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log50Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log50Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log51Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .string],
        outputs: []
    )

    public static func log51(p0: EthAddress, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log51Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log51Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log51Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log52Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .address],
        outputs: []
    )

    public static func log52(p0: String, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log52Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log52Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log52Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log53Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log53(p0: EthAddress, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log53Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log53Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log53Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log54Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .string],
        outputs: []
    )

    public static func log54(p0: String, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log54Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log54Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log54Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log55Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .address],
        outputs: []
    )

    public static func log55(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log55Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log55Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log55Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log56Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .uint256],
        outputs: []
    )

    public static func log56(p0: String, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log56Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log56Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log56Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log57Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string],
        outputs: []
    )

    public static func log57(p0: Bool, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log57Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log57Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log57Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log58Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .address],
        outputs: []
    )

    public static func log58(p0: Bool, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log58Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log58Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log58Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log59Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .string],
        outputs: []
    )

    public static func log59(p0: BigUInt, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log59Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log59Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log59Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log60Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log60(p0: Bool, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log60Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log60Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log60Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log61Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool],
        outputs: []
    )

    public static func log61(p0: Bool, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log61Fn.encoded(with: [.bool(p0), .bool(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log61Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log61Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log62Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .string],
        outputs: []
    )

    public static func log62(p0: Bool, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log62Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log62Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log62Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log63Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .address],
        outputs: []
    )

    public static func log63(p0: Bool, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log63Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log63Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log63Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log64Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .bool],
        outputs: []
    )

    public static func log64(p0: String, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log64Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log64Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log64Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log65Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .uint256],
        outputs: []
    )

    public static func log65(p0: BigUInt, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log65Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log65Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log65Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log66Fn = ABI.Function(
        name: "log",
        inputs: [.address],
        outputs: []
    )

    public static func log66(p0: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log66Fn.encoded(with: [.address(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log66Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log66Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log67Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .bool],
        outputs: []
    )

    public static func log67(p0: EthAddress, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log67Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log67Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log67Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log68Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string],
        outputs: []
    )

    public static func log68(p0: String, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log68Fn.encoded(with: [.string(p0), .string(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log68Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log68Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log69Fn = ABI.Function(
        name: "log",
        inputs: [.int256],
        outputs: []
    )

    public static func log69(p0: BigInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log69Fn.encoded(with: [.int256(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log69Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log69Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log70Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .string],
        outputs: []
    )

    public static func log70(p0: String, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log70Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log70Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log70Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log71Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .string],
        outputs: []
    )

    public static func log71(p0: EthAddress, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log71Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log71Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log71Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log72Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address],
        outputs: []
    )

    public static func log72(p0: String, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log72Fn.encoded(with: [.string(p0), .address(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log72Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log72Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log73Fn = ABI.Function(
        name: "log",
        inputs: [.bool],
        outputs: []
    )

    public static func log73(p0: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log73Fn.encoded(with: [.bool(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log73Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log73Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log74Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .address],
        outputs: []
    )

    public static func log74(p0: String, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log74Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log74Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log74Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log75Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log75(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log75Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log75Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log75Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log76Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address],
        outputs: []
    )

    public static func log76(p0: BigUInt, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log76Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log76Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log76Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log77Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log77(p0: String, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log77Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log77Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log77Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log78Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .bool],
        outputs: []
    )

    public static func log78(p0: EthAddress, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log78Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log78Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log78Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log79Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256],
        outputs: []
    )

    public static func log79(p0: Bool, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log79Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log79Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log79Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log80Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log80(p0: Bool, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log80Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log80Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log80Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log81Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256],
        outputs: []
    )

    public static func log81(p0: BigUInt, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log81Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log81Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log81Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log82Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log82(p0: EthAddress, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log82Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log82Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log82Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log83Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .uint256],
        outputs: []
    )

    public static func log83(p0: EthAddress, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log83Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log83Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log83Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log84Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256],
        outputs: []
    )

    public static func log84(p0: Bool, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log84Fn.encoded(with: [.bool(p0), .uint256(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log84Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log84Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log85Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .address],
        outputs: []
    )

    public static func log85(p0: BigUInt, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log85Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log85Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log85Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log86Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .bool],
        outputs: []
    )

    public static func log86(p0: Bool, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log86Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log86Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log86Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log87Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log87(p0: EthAddress, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log87Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log87Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log87Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log88Fn = ABI.Function(
        name: "log",
        inputs: [.string, .int256],
        outputs: []
    )

    public static func log88(p0: String, p1: BigInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log88Fn.encoded(with: [.string(p0), .int256(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log88Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log88Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log89Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .string],
        outputs: []
    )

    public static func log89(p0: BigUInt, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log89Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log89Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log89Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log90Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .uint256],
        outputs: []
    )

    public static func log90(p0: String, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log90Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log90Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log90Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log91Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .bool],
        outputs: []
    )

    public static func log91(p0: String, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log91Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log91Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log91Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log92Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .bool],
        outputs: []
    )

    public static func log92(p0: String, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log92Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log92Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log92Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log93Fn = ABI.Function(
        name: "log",
        inputs: [.string],
        outputs: []
    )

    public static func log93(p0: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log93Fn.encoded(with: [.string(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log93Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log93Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log94Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .address],
        outputs: []
    )

    public static func log94(p0: BigUInt, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log94Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log94Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log94Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log95Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .address],
        outputs: []
    )

    public static func log95(p0: String, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log95Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log95Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log95Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log96Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .string],
        outputs: []
    )

    public static func log96(p0: EthAddress, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log96Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log96Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log96Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log97Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .bool],
        outputs: []
    )

    public static func log97(p0: BigUInt, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log97Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log97Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log97Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log98Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .uint256],
        outputs: []
    )

    public static func log98(p0: EthAddress, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log98Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log98Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log98Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log99Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .bool],
        outputs: []
    )

    public static func log99(p0: Bool, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log99Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log99Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log99Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log100Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .uint256],
        outputs: []
    )

    public static func log100(p0: BigUInt, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log100Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log100Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log100Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log101Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .string],
        outputs: []
    )

    public static func log101(p0: EthAddress, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log101Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log101Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log101Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log102Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool],
        outputs: []
    )

    public static func log102(p0: BigUInt, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log102Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log102Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log102Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log103Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .address],
        outputs: []
    )

    public static func log103(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log103Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log103Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log103Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log104Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .string],
        outputs: []
    )

    public static func log104(p0: Bool, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log104Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log104Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log104Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log105Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log105(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log105Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log105Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log105Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log106Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .string],
        outputs: []
    )

    public static func log106(p0: Bool, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log106Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log106Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log106Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log107Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string],
        outputs: []
    )

    public static func log107(p0: String, p1: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log107Fn.encoded(with: [.string(p0), .string(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log107Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log107Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log108Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .uint256],
        outputs: []
    )

    public static func log108(p0: Bool, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log108Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log108Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log108Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log109Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool],
        outputs: []
    )

    public static func log109(p0: BigUInt, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log109Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log109Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log109Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log110Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log110(p0: String, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log110Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log110Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log110Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log111Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool],
        outputs: []
    )

    public static func log111(p0: Bool, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log111Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log111Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log111Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log112Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .bool],
        outputs: []
    )

    public static func log112(p0: EthAddress, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log112Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log112Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log112Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log113Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .uint256],
        outputs: []
    )

    public static func log113(p0: EthAddress, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log113Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log113Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log113Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log114Fn = ABI.Function(
        name: "log",
        inputs: [],
        outputs: []
    )

    public static func log114(withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log114Fn.encoded(with: [])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log114Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log114Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log115Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .string],
        outputs: []
    )

    public static func log115(p0: Bool, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log115Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log115Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log115Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log116Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .address],
        outputs: []
    )

    public static func log116(p0: Bool, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log116Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log116Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log116Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log117Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .address],
        outputs: []
    )

    public static func log117(p0: Bool, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log117Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log117Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log117Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log118Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .address],
        outputs: []
    )

    public static func log118(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log118Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log118Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log118Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log119Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256],
        outputs: []
    )

    public static func log119(p0: String, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log119Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log119Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log119Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log120Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string],
        outputs: []
    )

    public static func log120(p0: String, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log120Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log120Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log120Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log121Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log121(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log121Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log121Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log121Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log122Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .string],
        outputs: []
    )

    public static func log122(p0: String, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log122Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log122Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log122Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log123Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256],
        outputs: []
    )

    public static func log123(p0: BigUInt, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log123Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log123Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log123Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log124Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .string],
        outputs: []
    )

    public static func log124(p0: String, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log124Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log124Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log124Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log125Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .uint256],
        outputs: []
    )

    public static func log125(p0: BigUInt, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log125Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log125Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log125Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log126Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .address],
        outputs: []
    )

    public static func log126(p0: EthAddress, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log126Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log126Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log126Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log127Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address],
        outputs: []
    )

    public static func log127(p0: BigUInt, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log127Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log127Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log127Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log128Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .bool],
        outputs: []
    )

    public static func log128(p0: String, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log128Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log128Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log128Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log129Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .string],
        outputs: []
    )

    public static func log129(p0: EthAddress, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log129Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log129Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log129Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log130Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .uint256],
        outputs: []
    )

    public static func log130(p0: String, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log130Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log130Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log130Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log131Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .string],
        outputs: []
    )

    public static func log131(p0: String, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log131Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log131Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log131Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log132Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log132(p0: BigUInt, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log132Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log132Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log132Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log133Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .string],
        outputs: []
    )

    public static func log133(p0: String, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log133Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log133Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log133Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log134Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .address],
        outputs: []
    )

    public static func log134(p0: String, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log134Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log134Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log134Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log135Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .bool],
        outputs: []
    )

    public static func log135(p0: String, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log135Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log135Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log135Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log136Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .bool],
        outputs: []
    )

    public static func log136(p0: EthAddress, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log136Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log136Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log136Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log137Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .bool],
        outputs: []
    )

    public static func log137(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log137Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log137Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log137Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log138Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256],
        outputs: []
    )

    public static func log138(p0: Bool, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log138Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log138Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log138Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log139Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .address],
        outputs: []
    )

    public static func log139(p0: BigUInt, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log139Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log139Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log139Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log140Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log140(p0: Bool, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log140Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log140Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log140Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log141Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .address],
        outputs: []
    )

    public static func log141(p0: EthAddress, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log141Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log141Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log141Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log142Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string],
        outputs: []
    )

    public static func log142(p0: BigUInt, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log142Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log142Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log142Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log143Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .address],
        outputs: []
    )

    public static func log143(p0: String, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log143Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log143Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log143Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log144Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string],
        outputs: []
    )

    public static func log144(p0: BigUInt, p1: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log144Fn.encoded(with: [.uint256(p0), .string(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log144Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log144Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log145Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log145(p0: String, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log145Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log145Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log145Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log146Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .address],
        outputs: []
    )

    public static func log146(p0: EthAddress, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log146Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log146Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log146Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log147Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .address],
        outputs: []
    )

    public static func log147(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log147Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log147Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log147Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log148Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log148(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log148Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log148Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log148Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log149Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool],
        outputs: []
    )

    public static func log149(p0: EthAddress, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log149Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log149Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log149Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log150Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256],
        outputs: []
    )

    public static func log150(p0: EthAddress, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log150Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log150Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log150Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log151Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .string],
        outputs: []
    )

    public static func log151(p0: BigUInt, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log151Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log151Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log151Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log152Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .bool],
        outputs: []
    )

    public static func log152(p0: BigUInt, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log152Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log152Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log152Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log153Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address],
        outputs: []
    )

    public static func log153(p0: BigUInt, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log153Fn.encoded(with: [.uint256(p0), .address(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log153Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log153Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log154Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .address],
        outputs: []
    )

    public static func log154(p0: BigUInt, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log154Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log154Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log154Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log155Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log155(p0: Bool, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log155Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log155Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log155Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log156Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .bool],
        outputs: []
    )

    public static func log156(p0: Bool, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log156Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log156Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log156Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log157Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .bool],
        outputs: []
    )

    public static func log157(p0: Bool, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log157Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log157Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log157Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log158Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .string],
        outputs: []
    )

    public static func log158(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log158Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log158Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log158Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log159Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .string],
        outputs: []
    )

    public static func log159(p0: Bool, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log159Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log159Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log159Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log160Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .address],
        outputs: []
    )

    public static func log160(p0: String, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log160Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log160Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log160Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log161Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log161(p0: Bool, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log161Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log161Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log161Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log162Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .bool],
        outputs: []
    )

    public static func log162(p0: Bool, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log162Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log162Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log162Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log163Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .bool],
        outputs: []
    )

    public static func log163(p0: EthAddress, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log163Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log163Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log163Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log164Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .address],
        outputs: []
    )

    public static func log164(p0: Bool, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log164Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log164Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log164Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log165Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .address],
        outputs: []
    )

    public static func log165(p0: String, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log165Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log165Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log165Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log166Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string],
        outputs: []
    )

    public static func log166(p0: BigUInt, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log166Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log166Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log166Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log167Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .uint256],
        outputs: []
    )

    public static func log167(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log167Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log167Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log167Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log168Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .string],
        outputs: []
    )

    public static func log168(p0: String, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log168Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log168Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log168Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log169Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log169(p0: BigUInt, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log169Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log169Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log169Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log170Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string],
        outputs: []
    )

    public static func log170(p0: EthAddress, p1: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log170Fn.encoded(with: [.address(p0), .string(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log170Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log170Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log171Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool],
        outputs: []
    )

    public static func log171(p0: EthAddress, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log171Fn.encoded(with: [.address(p0), .bool(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log171Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log171Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log172Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log172(p0: String, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log172Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log172Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log172Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log173Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .bool],
        outputs: []
    )

    public static func log173(p0: String, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log173Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log173Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log173Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log174Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .bool],
        outputs: []
    )

    public static func log174(p0: BigUInt, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log174Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log174Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log174Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log175Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address],
        outputs: []
    )

    public static func log175(p0: BigUInt, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log175Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log175Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log175Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log176Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address],
        outputs: []
    )

    public static func log176(p0: EthAddress, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log176Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log176Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log176Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log177Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .uint256],
        outputs: []
    )

    public static func log177(p0: Bool, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log177Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log177Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log177Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log178Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log178(p0: Bool, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log178Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log178Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log178Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log179Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .address],
        outputs: []
    )

    public static func log179(p0: String, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log179Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log179Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log179Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log180Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .uint256],
        outputs: []
    )

    public static func log180(p0: String, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log180Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log180Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log180Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log181Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .bool],
        outputs: []
    )

    public static func log181(p0: String, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log181Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log181Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log181Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log182Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .string],
        outputs: []
    )

    public static func log182(p0: Bool, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log182Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log182Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log182Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log183Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log183(p0: Bool, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log183Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log183Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log183Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log184Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .string],
        outputs: []
    )

    public static func log184(p0: String, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log184Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log184Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log184Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log185Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .uint256],
        outputs: []
    )

    public static func log185(p0: EthAddress, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log185Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log185Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log185Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log186Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .bool],
        outputs: []
    )

    public static func log186(p0: String, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log186Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log186Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log186Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log187Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log187(p0: BigUInt, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log187Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log187Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log187Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log188Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func log188(p0: EthAddress, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log188Fn.encoded(with: [.address(p0), .uint256(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log188Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log188Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log189Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool],
        outputs: []
    )

    public static func log189(p0: String, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log189Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log189Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log189Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log190Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address],
        outputs: []
    )

    public static func log190(p0: Bool, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log190Fn.encoded(with: [.bool(p0), .address(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log190Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log190Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log191Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log191(p0: String, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log191Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log191Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log191Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log192Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string],
        outputs: []
    )

    public static func log192(p0: BigUInt, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log192Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log192Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log192Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log193Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .string],
        outputs: []
    )

    public static func log193(p0: EthAddress, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log193Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log193Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log193Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log194Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .address],
        outputs: []
    )

    public static func log194(p0: BigUInt, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log194Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log194Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log194Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log195Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log195(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log195Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log195Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log195Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log196Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .bool],
        outputs: []
    )

    public static func log196(p0: String, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log196Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log196Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log196Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log197Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log197(p0: String, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log197Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log197Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log197Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log198Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .address],
        outputs: []
    )

    public static func log198(p0: Bool, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log198Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log198Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log198Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log199Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log199(p0: EthAddress, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log199Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log199Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log199Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log200Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .address],
        outputs: []
    )

    public static func log200(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log200Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log200Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log200Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log201Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log201(p0: String, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log201Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log201Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log201Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log202Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log202(p0: Bool, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log202Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log202Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log202Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log203Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .uint256],
        outputs: []
    )

    public static func log203(p0: String, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log203Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log203Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log203Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log204Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .uint256],
        outputs: []
    )

    public static func log204(p0: String, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log204Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log204Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log204Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log205Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .address],
        outputs: []
    )

    public static func log205(p0: EthAddress, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log205Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log205Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log205Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log206Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string],
        outputs: []
    )

    public static func log206(p0: Bool, p1: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log206Fn.encoded(with: [.bool(p0), .string(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log206Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log206Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log207Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .bool],
        outputs: []
    )

    public static func log207(p0: BigUInt, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log207Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log207Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log207Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log208Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .string],
        outputs: []
    )

    public static func log208(p0: BigUInt, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log208Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log208Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log208Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log209Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .string],
        outputs: []
    )

    public static func log209(p0: Bool, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log209Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log209Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log209Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log210Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log210(p0: BigUInt, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log210Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log210Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log210Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log211Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .uint256],
        outputs: []
    )

    public static func log211(p0: String, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log211Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log211Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log211Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log212Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address],
        outputs: []
    )

    public static func log212(p0: String, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log212Fn.encoded(with: [.string(p0), .bool(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log212Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log212Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log213Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .address],
        outputs: []
    )

    public static func log213(p0: String, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log213Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log213Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log213Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log214Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .uint256],
        outputs: []
    )

    public static func log214(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log214Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log214Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log214Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log215Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .bool],
        outputs: []
    )

    public static func log215(p0: String, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log215Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log215Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log215Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log216Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address],
        outputs: []
    )

    public static func log216(p0: Bool, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log216Fn.encoded(with: [.bool(p0), .string(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log216Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log216Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log217Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address],
        outputs: []
    )

    public static func log217(p0: String, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log217Fn.encoded(with: [.string(p0), .string(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log217Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log217Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log218Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .address],
        outputs: []
    )

    public static func log218(p0: Bool, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log218Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log218Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log218Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log219Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .address],
        outputs: []
    )

    public static func log219(p0: BigUInt, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log219Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log219Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log219Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log220Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .address],
        outputs: []
    )

    public static func log220(p0: Bool, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log220Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log220Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log220Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log221Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .bool],
        outputs: []
    )

    public static func log221(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log221Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log221Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log221Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log222Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool],
        outputs: []
    )

    public static func log222(p0: BigUInt, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log222Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log222Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log222Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log223Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .string],
        outputs: []
    )

    public static func log223(p0: BigUInt, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log223Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log223Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log223Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log224Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256],
        outputs: []
    )

    public static func log224(p0: EthAddress, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log224Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log224Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log224Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log225Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .address],
        outputs: []
    )

    public static func log225(p0: BigUInt, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log225Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log225Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log225Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log226Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .string],
        outputs: []
    )

    public static func log226(p0: String, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log226Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log226Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log226Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log227Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .address],
        outputs: []
    )

    public static func log227(p0: EthAddress, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log227Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log227Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log227Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log228Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .string],
        outputs: []
    )

    public static func log228(p0: String, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log228Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log228Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log228Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log229Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .address],
        outputs: []
    )

    public static func log229(p0: EthAddress, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log229Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log229Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log229Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log230Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .string],
        outputs: []
    )

    public static func log230(p0: Bool, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log230Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log230Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log230Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log231Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .bool],
        outputs: []
    )

    public static func log231(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log231Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log231Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log231Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log232Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .address],
        outputs: []
    )

    public static func log232(p0: BigUInt, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log232Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log232Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log232Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log233Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string],
        outputs: []
    )

    public static func log233(p0: EthAddress, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log233Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log233Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log233Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log234Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .address],
        outputs: []
    )

    public static func log234(p0: EthAddress, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log234Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log234Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log234Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log235Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .string],
        outputs: []
    )

    public static func log235(p0: BigUInt, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log235Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log235Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log235Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log236Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .uint256],
        outputs: []
    )

    public static func log236(p0: Bool, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log236Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log236Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log236Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log237Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .bool],
        outputs: []
    )

    public static func log237(p0: EthAddress, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log237Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log237Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log237Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log238Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .string],
        outputs: []
    )

    public static func log238(p0: Bool, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log238Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log238Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log238Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log239Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .uint256],
        outputs: []
    )

    public static func log239(p0: EthAddress, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log239Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log239Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log239Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log240Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log240(p0: String, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log240Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log240Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log240Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log241Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .string],
        outputs: []
    )

    public static func log241(p0: String, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log241Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log241Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log241Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log242Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .string],
        outputs: []
    )

    public static func log242(p0: EthAddress, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log242Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log242Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log242Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log243Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .address],
        outputs: []
    )

    public static func log243(p0: String, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log243Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log243Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log243Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log244Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log244(p0: BigUInt, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log244Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log244Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log244Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log245Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .string],
        outputs: []
    )

    public static func log245(p0: String, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log245Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log245Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log245Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log246Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .string],
        outputs: []
    )

    public static func log246(p0: BigUInt, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log246Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log246Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log246Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log247Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .address],
        outputs: []
    )

    public static func log247(p0: BigUInt, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log247Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log247Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log247Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log248Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .uint256],
        outputs: []
    )

    public static func log248(p0: BigUInt, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log248Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log248Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log248Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log249Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string],
        outputs: []
    )

    public static func log249(p0: Bool, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log249Fn.encoded(with: [.bool(p0), .string(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log249Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log249Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log250Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool],
        outputs: []
    )

    public static func log250(p0: String, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log250Fn.encoded(with: [.string(p0), .string(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log250Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log250Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log251Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string],
        outputs: []
    )

    public static func log251(p0: BigUInt, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log251Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log251Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log251Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log252Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .bool],
        outputs: []
    )

    public static func log252(p0: BigUInt, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log252Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log252Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log252Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log253Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .bool],
        outputs: []
    )

    public static func log253(p0: Bool, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log253Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log253Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log253Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log254Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .bool],
        outputs: []
    )

    public static func log254(p0: String, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log254Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log254Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log254Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log255Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256],
        outputs: []
    )

    public static func log255(p0: String, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log255Fn.encoded(with: [.string(p0), .uint256(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log255Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log255Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log256Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256],
        outputs: []
    )

    public static func log256(p0: EthAddress, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log256Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log256Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log256Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log257Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .bool],
        outputs: []
    )

    public static func log257(p0: BigUInt, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log257Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log257Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log257Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log258Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .string],
        outputs: []
    )

    public static func log258(p0: BigUInt, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log258Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log258Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log258Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log259Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .bool],
        outputs: []
    )

    public static func log259(p0: Bool, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log259Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log259Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log259Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log260Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .bool],
        outputs: []
    )

    public static func log260(p0: BigUInt, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log260Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log260Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log260Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log261Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .string],
        outputs: []
    )

    public static func log261(p0: EthAddress, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log261Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log261Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log261Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log262Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address],
        outputs: []
    )

    public static func log262(p0: BigUInt, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log262Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log262Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log262Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log263Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log263(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log263Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log263Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log263Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log264Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log264(p0: Bool, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log264Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log264Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log264Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log265Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log265(p0: EthAddress, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log265Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log265Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log265Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log266Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .bool],
        outputs: []
    )

    public static func log266(p0: Bool, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log266Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log266Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log266Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log267Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .uint256],
        outputs: []
    )

    public static func log267(p0: Bool, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log267Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log267Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log267Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log268Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .address],
        outputs: []
    )

    public static func log268(p0: String, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log268Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log268Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log268Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log269Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .bool],
        outputs: []
    )

    public static func log269(p0: String, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log269Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log269Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log269Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log270Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool],
        outputs: []
    )

    public static func log270(p0: String, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log270Fn.encoded(with: [.string(p0), .bool(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log270Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log270Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log271Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string],
        outputs: []
    )

    public static func log271(p0: Bool, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log271Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log271Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log271Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log272Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log272(p0: EthAddress, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log272Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log272Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log272Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log273Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log273(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log273Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log273Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log273Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log274Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .string],
        outputs: []
    )

    public static func log274(p0: EthAddress, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log274Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log274Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log274Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log275Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log275(p0: String, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log275Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log275Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log275Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log276Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log276(p0: BigUInt, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log276Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log276Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log276Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log277Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool],
        outputs: []
    )

    public static func log277(p0: String, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log277Fn.encoded(with: [.string(p0), .address(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log277Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log277Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log278Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256],
        outputs: []
    )

    public static func log278(p0: String, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log278Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log278Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log278Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log279Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256],
        outputs: []
    )

    public static func log279(p0: String, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log279Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log279Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log279Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log280Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool],
        outputs: []
    )

    public static func log280(p0: String, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log280Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log280Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log280Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log281Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .bool],
        outputs: []
    )

    public static func log281(p0: EthAddress, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log281Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log281Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log281Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log282Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .bool],
        outputs: []
    )

    public static func log282(p0: BigUInt, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log282Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log282Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log282Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log283Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .address],
        outputs: []
    )

    public static func log283(p0: EthAddress, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log283Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log283Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log283Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log284Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log284(p0: Bool, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log284Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log284Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log284Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log285Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .uint256],
        outputs: []
    )

    public static func log285(p0: BigUInt, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log285Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log285Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log285Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log286Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool],
        outputs: []
    )

    public static func log286(p0: EthAddress, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log286Fn.encoded(with: [.address(p0), .string(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log286Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log286Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log287Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .bool],
        outputs: []
    )

    public static func log287(p0: EthAddress, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log287Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log287Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log287Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log288Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .address],
        outputs: []
    )

    public static func log288(p0: EthAddress, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log288Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log288Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log288Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log289Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log289(p0: BigUInt, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log289Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log289Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log289Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log290Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address],
        outputs: []
    )

    public static func log290(p0: Bool, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log290Fn.encoded(with: [.bool(p0), .address(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log290Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log290Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log291Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .string],
        outputs: []
    )

    public static func log291(p0: BigUInt, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log291Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log291Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log291Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log292Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .address],
        outputs: []
    )

    public static func log292(p0: BigUInt, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log292Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log292Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log292Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log293Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .bool],
        outputs: []
    )

    public static func log293(p0: Bool, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log293Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log293Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log293Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log294Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .uint256],
        outputs: []
    )

    public static func log294(p0: String, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log294Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log294Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log294Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log295Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .string],
        outputs: []
    )

    public static func log295(p0: Bool, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log295Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log295Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log295Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log296Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address],
        outputs: []
    )

    public static func log296(p0: EthAddress, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log296Fn.encoded(with: [.address(p0), .address(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log296Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log296Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log297Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool],
        outputs: []
    )

    public static func log297(p0: Bool, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log297Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log297Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log297Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log298Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .bool],
        outputs: []
    )

    public static func log298(p0: Bool, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log298Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log298Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log298Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log299Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .string],
        outputs: []
    )

    public static func log299(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log299Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log299Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log299Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log300Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .string],
        outputs: []
    )

    public static func log300(p0: BigUInt, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log300Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log300Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log300Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log301Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .string],
        outputs: []
    )

    public static func log301(p0: BigUInt, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log301Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log301Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log301Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log302Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .string],
        outputs: []
    )

    public static func log302(p0: String, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log302Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log302Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log302Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log303Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string],
        outputs: []
    )

    public static func log303(p0: Bool, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log303Fn.encoded(with: [.bool(p0), .address(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log303Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log303Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log304Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .string],
        outputs: []
    )

    public static func log304(p0: EthAddress, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log304Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log304Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log304Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log305Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .address],
        outputs: []
    )

    public static func log305(p0: String, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log305Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log305Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log305Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log306Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .address],
        outputs: []
    )

    public static func log306(p0: String, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log306Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log306Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log306Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log307Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string],
        outputs: []
    )

    public static func log307(p0: String, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log307Fn.encoded(with: [.string(p0), .address(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log307Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log307Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log308Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log308(p0: String, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log308Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log308Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log308Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log309Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string],
        outputs: []
    )

    public static func log309(p0: String, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log309Fn.encoded(with: [.string(p0), .bool(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log309Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log309Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log310Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .bool],
        outputs: []
    )

    public static func log310(p0: Bool, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log310Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log310Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log310Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log311Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .bool],
        outputs: []
    )

    public static func log311(p0: BigUInt, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log311Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log311Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log311Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log312Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .uint256],
        outputs: []
    )

    public static func log312(p0: Bool, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log312Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log312Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log312Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log313Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log313(p0: String, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log313Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log313Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log313Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log314Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .bool],
        outputs: []
    )

    public static func log314(p0: Bool, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log314Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log314Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log314Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log315Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .uint256],
        outputs: []
    )

    public static func log315(p0: BigUInt, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log315Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log315Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log315Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log316Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool],
        outputs: []
    )

    public static func log316(p0: Bool, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log316Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log316Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log316Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log317Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .string],
        outputs: []
    )

    public static func log317(p0: String, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log317Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log317Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log317Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log318Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log318(p0: BigUInt, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log318Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log318Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log318Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log319Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool],
        outputs: []
    )

    public static func log319(p0: EthAddress, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log319Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log319Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log319Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log320Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .bool],
        outputs: []
    )

    public static func log320(p0: BigUInt, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log320Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log320Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log320Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log321Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .address],
        outputs: []
    )

    public static func log321(p0: String, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log321Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log321Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log321Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log322Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .uint256],
        outputs: []
    )

    public static func log322(p0: EthAddress, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log322Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log322Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log322Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log323Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .address],
        outputs: []
    )

    public static func log323(p0: BigUInt, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log323Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log323Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log323Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log324Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .address],
        outputs: []
    )

    public static func log324(p0: BigUInt, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log324Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log324Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log324Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log325Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address],
        outputs: []
    )

    public static func log325(p0: EthAddress, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log325Fn.encoded(with: [.address(p0), .string(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log325Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log325Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log326Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address],
        outputs: []
    )

    public static func log326(p0: EthAddress, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log326Fn.encoded(with: [.address(p0), .bool(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log326Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log326Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log327Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool],
        outputs: []
    )

    public static func log327(p0: EthAddress, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log327Fn.encoded(with: [.address(p0), .address(p1), .bool(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log327Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log327Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log328Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log328(p0: String, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log328Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log328Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log328Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log329Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .address],
        outputs: []
    )

    public static func log329(p0: Bool, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log329Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log329Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log329Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log330Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .string],
        outputs: []
    )

    public static func log330(p0: Bool, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log330Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log330Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log330Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log331Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256],
        outputs: []
    )

    public static func log331(p0: BigUInt, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log331Fn.encoded(with: [.uint256(p0), .uint256(p1)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log331Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log331Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log332Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .string],
        outputs: []
    )

    public static func log332(p0: EthAddress, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log332Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log332Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log332Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log333Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .string],
        outputs: []
    )

    public static func log333(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log333Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log333Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log333Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log334Fn = ABI.Function(
        name: "log",
        inputs: [.uint256],
        outputs: []
    )

    public static func log334(p0: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log334Fn.encoded(with: [.uint256(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log334Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log334Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log335Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log335(p0: String, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log335Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log335Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log335Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log336Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .address],
        outputs: []
    )

    public static func log336(p0: Bool, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log336Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log336Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log336Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log337Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log337(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log337Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log337Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log337Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log338Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string],
        outputs: []
    )

    public static func log338(p0: EthAddress, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log338Fn.encoded(with: [.address(p0), .string(p1), .string(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log338Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log338Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log339Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .bool],
        outputs: []
    )

    public static func log339(p0: String, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log339Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log339Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log339Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log340Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address],
        outputs: []
    )

    public static func log340(p0: String, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log340Fn.encoded(with: [.string(p0), .address(p1), .address(p2)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log340Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log340Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log341Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .string],
        outputs: []
    )

    public static func log341(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log341Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log341Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log341Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log342Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .address],
        outputs: []
    )

    public static func log342(p0: Bool, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try log342Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log342Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log342Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logAddressFn = ABI.Function(
        name: "logAddress",
        inputs: [.address],
        outputs: []
    )

    public static func logAddress(p0: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logAddressFn.encoded(with: [.address(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logAddressFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logAddressFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBoolFn = ABI.Function(
        name: "logBool",
        inputs: [.bool],
        outputs: []
    )

    public static func logBool(p0: Bool, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBoolFn.encoded(with: [.bool(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBoolFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBoolFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytesFn = ABI.Function(
        name: "logBytes",
        inputs: [.bytes],
        outputs: []
    )

    public static func logBytes(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytesFn.encoded(with: [.bytes(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytesFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytesFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes1Fn = ABI.Function(
        name: "logBytes1",
        inputs: [.bytes1],
        outputs: []
    )

    public static func logBytes1(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes1Fn.encoded(with: [.bytes1(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes1Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes1Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes10Fn = ABI.Function(
        name: "logBytes10",
        inputs: [.bytes10],
        outputs: []
    )

    public static func logBytes10(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes10Fn.encoded(with: [.bytes10(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes10Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes10Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes11Fn = ABI.Function(
        name: "logBytes11",
        inputs: [.bytes11],
        outputs: []
    )

    public static func logBytes11(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes11Fn.encoded(with: [.bytes11(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes11Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes11Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes12Fn = ABI.Function(
        name: "logBytes12",
        inputs: [.bytes12],
        outputs: []
    )

    public static func logBytes12(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes12Fn.encoded(with: [.bytes12(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes12Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes12Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes13Fn = ABI.Function(
        name: "logBytes13",
        inputs: [.bytes13],
        outputs: []
    )

    public static func logBytes13(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes13Fn.encoded(with: [.bytes13(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes13Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes13Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes14Fn = ABI.Function(
        name: "logBytes14",
        inputs: [.bytes14],
        outputs: []
    )

    public static func logBytes14(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes14Fn.encoded(with: [.bytes14(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes14Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes14Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes15Fn = ABI.Function(
        name: "logBytes15",
        inputs: [.bytes15],
        outputs: []
    )

    public static func logBytes15(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes15Fn.encoded(with: [.bytes15(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes15Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes15Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes16Fn = ABI.Function(
        name: "logBytes16",
        inputs: [.bytes16],
        outputs: []
    )

    public static func logBytes16(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes16Fn.encoded(with: [.bytes16(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes16Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes16Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes17Fn = ABI.Function(
        name: "logBytes17",
        inputs: [.bytes17],
        outputs: []
    )

    public static func logBytes17(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes17Fn.encoded(with: [.bytes17(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes17Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes17Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes18Fn = ABI.Function(
        name: "logBytes18",
        inputs: [.bytes18],
        outputs: []
    )

    public static func logBytes18(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes18Fn.encoded(with: [.bytes18(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes18Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes18Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes19Fn = ABI.Function(
        name: "logBytes19",
        inputs: [.bytes19],
        outputs: []
    )

    public static func logBytes19(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes19Fn.encoded(with: [.bytes19(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes19Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes19Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes2Fn = ABI.Function(
        name: "logBytes2",
        inputs: [.bytes2],
        outputs: []
    )

    public static func logBytes2(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes2Fn.encoded(with: [.bytes2(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes2Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes2Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes20Fn = ABI.Function(
        name: "logBytes20",
        inputs: [.bytes20],
        outputs: []
    )

    public static func logBytes20(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes20Fn.encoded(with: [.bytes20(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes20Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes20Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes21Fn = ABI.Function(
        name: "logBytes21",
        inputs: [.bytes21],
        outputs: []
    )

    public static func logBytes21(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes21Fn.encoded(with: [.bytes21(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes21Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes21Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes22Fn = ABI.Function(
        name: "logBytes22",
        inputs: [.bytes22],
        outputs: []
    )

    public static func logBytes22(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes22Fn.encoded(with: [.bytes22(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes22Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes22Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes23Fn = ABI.Function(
        name: "logBytes23",
        inputs: [.bytes23],
        outputs: []
    )

    public static func logBytes23(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes23Fn.encoded(with: [.bytes23(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes23Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes23Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes24Fn = ABI.Function(
        name: "logBytes24",
        inputs: [.bytes24],
        outputs: []
    )

    public static func logBytes24(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes24Fn.encoded(with: [.bytes24(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes24Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes24Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes25Fn = ABI.Function(
        name: "logBytes25",
        inputs: [.bytes25],
        outputs: []
    )

    public static func logBytes25(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes25Fn.encoded(with: [.bytes25(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes25Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes25Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes26Fn = ABI.Function(
        name: "logBytes26",
        inputs: [.bytes26],
        outputs: []
    )

    public static func logBytes26(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes26Fn.encoded(with: [.bytes26(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes26Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes26Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes27Fn = ABI.Function(
        name: "logBytes27",
        inputs: [.bytes27],
        outputs: []
    )

    public static func logBytes27(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes27Fn.encoded(with: [.bytes27(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes27Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes27Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes28Fn = ABI.Function(
        name: "logBytes28",
        inputs: [.bytes28],
        outputs: []
    )

    public static func logBytes28(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes28Fn.encoded(with: [.bytes28(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes28Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes28Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes29Fn = ABI.Function(
        name: "logBytes29",
        inputs: [.bytes29],
        outputs: []
    )

    public static func logBytes29(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes29Fn.encoded(with: [.bytes29(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes29Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes29Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes3Fn = ABI.Function(
        name: "logBytes3",
        inputs: [.bytes3],
        outputs: []
    )

    public static func logBytes3(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes3Fn.encoded(with: [.bytes3(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes3Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes3Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes30Fn = ABI.Function(
        name: "logBytes30",
        inputs: [.bytes30],
        outputs: []
    )

    public static func logBytes30(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes30Fn.encoded(with: [.bytes30(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes30Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes30Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes31Fn = ABI.Function(
        name: "logBytes31",
        inputs: [.bytes31],
        outputs: []
    )

    public static func logBytes31(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes31Fn.encoded(with: [.bytes31(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes31Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes31Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes32Fn = ABI.Function(
        name: "logBytes32",
        inputs: [.bytes32],
        outputs: []
    )

    public static func logBytes32(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes32Fn.encoded(with: [.bytes32(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes32Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes32Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes4Fn = ABI.Function(
        name: "logBytes4",
        inputs: [.bytes4],
        outputs: []
    )

    public static func logBytes4(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes4Fn.encoded(with: [.bytes4(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes4Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes4Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes5Fn = ABI.Function(
        name: "logBytes5",
        inputs: [.bytes5],
        outputs: []
    )

    public static func logBytes5(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes5Fn.encoded(with: [.bytes5(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes5Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes5Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes6Fn = ABI.Function(
        name: "logBytes6",
        inputs: [.bytes6],
        outputs: []
    )

    public static func logBytes6(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes6Fn.encoded(with: [.bytes6(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes6Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes6Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes7Fn = ABI.Function(
        name: "logBytes7",
        inputs: [.bytes7],
        outputs: []
    )

    public static func logBytes7(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes7Fn.encoded(with: [.bytes7(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes7Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes7Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes8Fn = ABI.Function(
        name: "logBytes8",
        inputs: [.bytes8],
        outputs: []
    )

    public static func logBytes8(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes8Fn.encoded(with: [.bytes8(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes8Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes8Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logBytes9Fn = ABI.Function(
        name: "logBytes9",
        inputs: [.bytes9],
        outputs: []
    )

    public static func logBytes9(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes9Fn.encoded(with: [.bytes9(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logBytes9Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logBytes9Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logIntFn = ABI.Function(
        name: "logInt",
        inputs: [.int256],
        outputs: []
    )

    public static func logInt(p0: BigInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logIntFn.encoded(with: [.int256(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logIntFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logIntFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logStringFn = ABI.Function(
        name: "logString",
        inputs: [.string],
        outputs: []
    )

    public static func logString(p0: String, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logStringFn.encoded(with: [.string(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logStringFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logStringFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let logUintFn = ABI.Function(
        name: "logUint",
        inputs: [.uint256],
        outputs: []
    )

    public static func logUint(p0: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Void, RevertReason> {
        do {
            let query = try logUintFn.encoded(with: [.uint256(p0)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try logUintFn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, logUintFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }
}
