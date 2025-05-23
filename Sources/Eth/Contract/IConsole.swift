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
    public static let functions: [ABI.Function] = [logFn, log__1Fn, log__2Fn, log__3Fn, log__4Fn, log__5Fn, log__6Fn, log__7Fn, log__8Fn, log__9Fn, log__10Fn, log__11Fn, log__12Fn, log__13Fn, log__14Fn, log__15Fn, log__16Fn, log__17Fn, log__18Fn, log__19Fn, log__20Fn, log__21Fn, log__22Fn, log__23Fn, log__24Fn, log__25Fn, log__26Fn, log__27Fn, log__28Fn, log__29Fn, log__30Fn, log__31Fn, log__32Fn, log__33Fn, log__34Fn, log__35Fn, log__36Fn, log__37Fn, log__38Fn, log__39Fn, log__40Fn, log__41Fn, log__42Fn, log__43Fn, log__44Fn, log__45Fn, log__46Fn, log__47Fn, log__48Fn, log__49Fn, log__50Fn, log__51Fn, log__52Fn, log__53Fn, log__54Fn, log__55Fn, log__56Fn, log__57Fn, log__58Fn, log__59Fn, log__60Fn, log__61Fn, log__62Fn, log__63Fn, log__64Fn, log__65Fn, log__66Fn, log__67Fn, log__68Fn, log__69Fn, log__70Fn, log__71Fn, log__72Fn, log__73Fn, log__74Fn, log__75Fn, log__76Fn, log__77Fn, log__78Fn, log__79Fn, log__80Fn, log__81Fn, log__82Fn, log__83Fn, log__84Fn, log__85Fn, log__86Fn, log__87Fn, log__88Fn, log__89Fn, log__90Fn, log__91Fn, log__92Fn, log__93Fn, log__94Fn, log__95Fn, log__96Fn, log__97Fn, log__98Fn, log__99Fn, log__100Fn, log__101Fn, log__102Fn, log__103Fn, log__104Fn, log__105Fn, log__106Fn, log__107Fn, log__108Fn, log__109Fn, log__110Fn, log__111Fn, log__112Fn, log__113Fn, log__114Fn, log__115Fn, log__116Fn, log__117Fn, log__118Fn, log__119Fn, log__120Fn, log__121Fn, log__122Fn, log__123Fn, log__124Fn, log__125Fn, log__126Fn, log__127Fn, log__128Fn, log__129Fn, log__130Fn, log__131Fn, log__132Fn, log__133Fn, log__134Fn, log__135Fn, log__136Fn, log__137Fn, log__138Fn, log__139Fn, log__140Fn, log__141Fn, log__142Fn, log__143Fn, log__144Fn, log__145Fn, log__146Fn, log__147Fn, log__148Fn, log__149Fn, log__150Fn, log__151Fn, log__152Fn, log__153Fn, log__154Fn, log__155Fn, log__156Fn, log__157Fn, log__158Fn, log__159Fn, log__160Fn, log__161Fn, log__162Fn, log__163Fn, log__164Fn, log__165Fn, log__166Fn, log__167Fn, log__168Fn, log__169Fn, log__170Fn, log__171Fn, log__172Fn, log__173Fn, log__174Fn, log__175Fn, log__176Fn, log__177Fn, log__178Fn, log__179Fn, log__180Fn, log__181Fn, log__182Fn, log__183Fn, log__184Fn, log__185Fn, log__186Fn, log__187Fn, log__188Fn, log__189Fn, log__190Fn, log__191Fn, log__192Fn, log__193Fn, log__194Fn, log__195Fn, log__196Fn, log__197Fn, log__198Fn, log__199Fn, log__200Fn, log__201Fn, log__202Fn, log__203Fn, log__204Fn, log__205Fn, log__206Fn, log__207Fn, log__208Fn, log__209Fn, log__210Fn, log__211Fn, log__212Fn, log__213Fn, log__214Fn, log__215Fn, log__216Fn, log__217Fn, log__218Fn, log__219Fn, log__220Fn, log__221Fn, log__222Fn, log__223Fn, log__224Fn, log__225Fn, log__226Fn, log__227Fn, log__228Fn, log__229Fn, log__230Fn, log__231Fn, log__232Fn, log__233Fn, log__234Fn, log__235Fn, log__236Fn, log__237Fn, log__238Fn, log__239Fn, log__240Fn, log__241Fn, log__242Fn, log__243Fn, log__244Fn, log__245Fn, log__246Fn, log__247Fn, log__248Fn, log__249Fn, log__250Fn, log__251Fn, log__252Fn, log__253Fn, log__254Fn, log__255Fn, log__256Fn, log__257Fn, log__258Fn, log__259Fn, log__260Fn, log__261Fn, log__262Fn, log__263Fn, log__264Fn, log__265Fn, log__266Fn, log__267Fn, log__268Fn, log__269Fn, log__270Fn, log__271Fn, log__272Fn, log__273Fn, log__274Fn, log__275Fn, log__276Fn, log__277Fn, log__278Fn, log__279Fn, log__280Fn, log__281Fn, log__282Fn, log__283Fn, log__284Fn, log__285Fn, log__286Fn, log__287Fn, log__288Fn, log__289Fn, log__290Fn, log__291Fn, log__292Fn, log__293Fn, log__294Fn, log__295Fn, log__296Fn, log__297Fn, log__298Fn, log__299Fn, log__300Fn, log__301Fn, log__302Fn, log__303Fn, log__304Fn, log__305Fn, log__306Fn, log__307Fn, log__308Fn, log__309Fn, log__310Fn, log__311Fn, log__312Fn, log__313Fn, log__314Fn, log__315Fn, log__316Fn, log__317Fn, log__318Fn, log__319Fn, log__320Fn, log__321Fn, log__322Fn, log__323Fn, log__324Fn, log__325Fn, log__326Fn, log__327Fn, log__328Fn, log__329Fn, log__330Fn, log__331Fn, log__332Fn, log__333Fn, log__334Fn, log__335Fn, log__336Fn, log__337Fn, log__338Fn, log__339Fn, log__340Fn, log__341Fn, log__342Fn, logAddressFn, logBoolFn, logBytesFn, logBytes1Fn, logBytes10Fn, logBytes11Fn, logBytes12Fn, logBytes13Fn, logBytes14Fn, logBytes15Fn, logBytes16Fn, logBytes17Fn, logBytes18Fn, logBytes19Fn, logBytes2Fn, logBytes20Fn, logBytes21Fn, logBytes22Fn, logBytes23Fn, logBytes24Fn, logBytes25Fn, logBytes26Fn, logBytes27Fn, logBytes28Fn, logBytes29Fn, logBytes3Fn, logBytes30Fn, logBytes31Fn, logBytes32Fn, logBytes4Fn, logBytes5Fn, logBytes6Fn, logBytes7Fn, logBytes8Fn, logBytes9Fn, logIntFn, logStringFn, logUintFn]
    public static let logFn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string],
        outputs: []
    )

    public static func log(p0: EthAddress, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logFn.encoded(with: [.address(p0), .address(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static let log__1Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log__1(p0: Bool, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__1Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__1Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__1Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__2Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address],
        outputs: []
    )

    public static func log__2(p0: EthAddress, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__2Fn.encoded(with: [.address(p0), .address(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__2Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__2Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__3Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .string],
        outputs: []
    )

    public static func log__3(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__3Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__3Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__3Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__4Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .string],
        outputs: []
    )

    public static func log__4(p0: String, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__4Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__4Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__4Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__5Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .uint256],
        outputs: []
    )

    public static func log__5(p0: BigUInt, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__5Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__5Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__5Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__6Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .uint256],
        outputs: []
    )

    public static func log__6(p0: Bool, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__6Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__6Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__6Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__7Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address],
        outputs: []
    )

    public static func log__7(p0: Bool, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__7Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__7Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__7Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__8Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .bool],
        outputs: []
    )

    public static func log__8(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__8Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__8Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__8Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__9Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .string],
        outputs: []
    )

    public static func log__9(p0: EthAddress, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__9Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__9Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__9Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__10Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log__10(p0: Bool, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__10Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__10Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__10Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__11Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .uint256],
        outputs: []
    )

    public static func log__11(p0: Bool, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__11Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__11Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__11Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__12Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log__12(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__12Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__12Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__12Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__13Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256],
        outputs: []
    )

    public static func log__13(p0: String, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__13Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__13Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__13Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__14Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .address],
        outputs: []
    )

    public static func log__14(p0: EthAddress, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__14Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__14Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__14Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__15Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .bool],
        outputs: []
    )

    public static func log__15(p0: EthAddress, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__15Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__15Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__15Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__16Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .bool],
        outputs: []
    )

    public static func log__16(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__16Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__16Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__16Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__17Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .bool],
        outputs: []
    )

    public static func log__17(p0: EthAddress, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__17Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__17Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__17Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__18Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log__18(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__18Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__18Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__18Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__19Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .address],
        outputs: []
    )

    public static func log__19(p0: String, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__19Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__19Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__19Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__20Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address],
        outputs: []
    )

    public static func log__20(p0: Bool, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__20Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__20Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__20Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__21Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256],
        outputs: []
    )

    public static func log__21(p0: Bool, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__21Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__21Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__21Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__22Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .string],
        outputs: []
    )

    public static func log__22(p0: Bool, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__22Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__22Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__22Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__23Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256],
        outputs: []
    )

    public static func log__23(p0: Bool, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__23Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__23Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__23Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__24Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .address],
        outputs: []
    )

    public static func log__24(p0: Bool, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__24Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__24Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__24Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__25Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log__25(p0: Bool, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__25Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__25Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__25Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__26Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .address],
        outputs: []
    )

    public static func log__26(p0: Bool, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__26Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__26Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__26Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__27Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .uint256],
        outputs: []
    )

    public static func log__27(p0: EthAddress, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__27Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__27Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__27Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__28Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .address],
        outputs: []
    )

    public static func log__28(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__28Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__28Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__28Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__29Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .bool],
        outputs: []
    )

    public static func log__29(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__29Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__29Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__29Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__30Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .uint256],
        outputs: []
    )

    public static func log__30(p0: Bool, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__30Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__30Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__30Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__31Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .string],
        outputs: []
    )

    public static func log__31(p0: Bool, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__31Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__31Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__31Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__32Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256],
        outputs: []
    )

    public static func log__32(p0: EthAddress, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__32Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__32Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__32Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__33Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool],
        outputs: []
    )

    public static func log__33(p0: Bool, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__33Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__33Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__33Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__34Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log__34(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__34Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__34Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__34Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__35Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .address],
        outputs: []
    )

    public static func log__35(p0: EthAddress, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__35Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__35Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__35Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__36Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .string],
        outputs: []
    )

    public static func log__36(p0: Bool, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__36Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__36Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__36Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__37Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .string],
        outputs: []
    )

    public static func log__37(p0: Bool, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__37Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__37Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__37Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__38Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .address],
        outputs: []
    )

    public static func log__38(p0: Bool, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__38Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__38Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__38Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__39Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address],
        outputs: []
    )

    public static func log__39(p0: String, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__39Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__39Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__39Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__40Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool],
        outputs: []
    )

    public static func log__40(p0: BigUInt, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__40Fn.encoded(with: [.uint256(p0), .bool(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__40Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__40Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__41Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .address],
        outputs: []
    )

    public static func log__41(p0: Bool, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__41Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__41Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__41Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__42Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .string],
        outputs: []
    )

    public static func log__42(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__42Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__42Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__42Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__43Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log__43(p0: EthAddress, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__43Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__43Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__43Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__44Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .bool],
        outputs: []
    )

    public static func log__44(p0: Bool, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__44Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__44Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__44Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__45Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256],
        outputs: []
    )

    public static func log__45(p0: BigUInt, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__45Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__45Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__45Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__46Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .address],
        outputs: []
    )

    public static func log__46(p0: EthAddress, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__46Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__46Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__46Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__47Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool],
        outputs: []
    )

    public static func log__47(p0: BigUInt, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__47Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__47Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__47Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__48Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log__48(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__48Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__48Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__48Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__49Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string],
        outputs: []
    )

    public static func log__49(p0: EthAddress, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__49Fn.encoded(with: [.address(p0), .bool(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__49Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__49Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__50Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .string],
        outputs: []
    )

    public static func log__50(p0: BigUInt, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__50Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__50Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__50Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__51Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .string],
        outputs: []
    )

    public static func log__51(p0: EthAddress, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__51Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__51Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__51Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__52Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .address],
        outputs: []
    )

    public static func log__52(p0: String, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__52Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__52Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__52Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__53Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log__53(p0: EthAddress, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__53Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__53Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__53Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__54Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .string],
        outputs: []
    )

    public static func log__54(p0: String, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__54Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__54Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__54Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__55Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .address],
        outputs: []
    )

    public static func log__55(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__55Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__55Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__55Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__56Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .uint256],
        outputs: []
    )

    public static func log__56(p0: String, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__56Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__56Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__56Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__57Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string],
        outputs: []
    )

    public static func log__57(p0: Bool, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__57Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__57Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__57Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__58Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .address],
        outputs: []
    )

    public static func log__58(p0: Bool, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__58Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__58Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__58Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__59Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .string],
        outputs: []
    )

    public static func log__59(p0: BigUInt, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__59Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__59Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__59Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__60Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log__60(p0: Bool, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__60Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__60Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__60Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__61Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool],
        outputs: []
    )

    public static func log__61(p0: Bool, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__61Fn.encoded(with: [.bool(p0), .bool(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__61Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__61Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__62Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .string],
        outputs: []
    )

    public static func log__62(p0: Bool, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__62Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__62Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__62Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__63Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .address],
        outputs: []
    )

    public static func log__63(p0: Bool, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__63Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__63Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__63Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__64Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .bool],
        outputs: []
    )

    public static func log__64(p0: String, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__64Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__64Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__64Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__65Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .uint256],
        outputs: []
    )

    public static func log__65(p0: BigUInt, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__65Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__65Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__65Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__66Fn = ABI.Function(
        name: "log",
        inputs: [.address],
        outputs: []
    )

    public static func log__66(p0: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__66Fn.encoded(with: [.address(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__66Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__66Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__67Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .bool],
        outputs: []
    )

    public static func log__67(p0: EthAddress, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__67Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__67Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__67Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__68Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string],
        outputs: []
    )

    public static func log__68(p0: String, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__68Fn.encoded(with: [.string(p0), .string(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__68Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__68Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__69Fn = ABI.Function(
        name: "log",
        inputs: [.int256],
        outputs: []
    )

    public static func log__69(p0: BigInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__69Fn.encoded(with: [.int256(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__69Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__69Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__70Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .string],
        outputs: []
    )

    public static func log__70(p0: String, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__70Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__70Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__70Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__71Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .string],
        outputs: []
    )

    public static func log__71(p0: EthAddress, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__71Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__71Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__71Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__72Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address],
        outputs: []
    )

    public static func log__72(p0: String, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__72Fn.encoded(with: [.string(p0), .address(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__72Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__72Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__73Fn = ABI.Function(
        name: "log",
        inputs: [.bool],
        outputs: []
    )

    public static func log__73(p0: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__73Fn.encoded(with: [.bool(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__73Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__73Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__74Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .address],
        outputs: []
    )

    public static func log__74(p0: String, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__74Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__74Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__74Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__75Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log__75(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__75Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__75Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__75Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__76Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address],
        outputs: []
    )

    public static func log__76(p0: BigUInt, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__76Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__76Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__76Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__77Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log__77(p0: String, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__77Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__77Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__77Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__78Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .bool],
        outputs: []
    )

    public static func log__78(p0: EthAddress, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__78Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__78Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__78Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__79Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256],
        outputs: []
    )

    public static func log__79(p0: Bool, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__79Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__79Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__79Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__80Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log__80(p0: Bool, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__80Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__80Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__80Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__81Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256],
        outputs: []
    )

    public static func log__81(p0: BigUInt, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__81Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__81Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__81Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__82Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log__82(p0: EthAddress, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__82Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__82Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__82Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__83Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .uint256],
        outputs: []
    )

    public static func log__83(p0: EthAddress, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__83Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__83Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__83Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__84Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256],
        outputs: []
    )

    public static func log__84(p0: Bool, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__84Fn.encoded(with: [.bool(p0), .uint256(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__84Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__84Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__85Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .address],
        outputs: []
    )

    public static func log__85(p0: BigUInt, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__85Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__85Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__85Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__86Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .bool],
        outputs: []
    )

    public static func log__86(p0: Bool, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__86Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__86Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__86Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__87Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log__87(p0: EthAddress, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__87Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__87Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__87Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__88Fn = ABI.Function(
        name: "log",
        inputs: [.string, .int256],
        outputs: []
    )

    public static func log__88(p0: String, p1: BigInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__88Fn.encoded(with: [.string(p0), .int256(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__88Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__88Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__89Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .string],
        outputs: []
    )

    public static func log__89(p0: BigUInt, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__89Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__89Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__89Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__90Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .uint256],
        outputs: []
    )

    public static func log__90(p0: String, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__90Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__90Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__90Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__91Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .bool],
        outputs: []
    )

    public static func log__91(p0: String, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__91Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__91Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__91Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__92Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .bool],
        outputs: []
    )

    public static func log__92(p0: String, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__92Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__92Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__92Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__93Fn = ABI.Function(
        name: "log",
        inputs: [.string],
        outputs: []
    )

    public static func log__93(p0: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__93Fn.encoded(with: [.string(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__93Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__93Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__94Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .address],
        outputs: []
    )

    public static func log__94(p0: BigUInt, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__94Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__94Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__94Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__95Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .address],
        outputs: []
    )

    public static func log__95(p0: String, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__95Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__95Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__95Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__96Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .string],
        outputs: []
    )

    public static func log__96(p0: EthAddress, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__96Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__96Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__96Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__97Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .bool],
        outputs: []
    )

    public static func log__97(p0: BigUInt, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__97Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__97Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__97Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__98Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .uint256],
        outputs: []
    )

    public static func log__98(p0: EthAddress, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__98Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__98Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__98Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__99Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .bool],
        outputs: []
    )

    public static func log__99(p0: Bool, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__99Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__99Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__99Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__100Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .uint256],
        outputs: []
    )

    public static func log__100(p0: BigUInt, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__100Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__100Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__100Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__101Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .string],
        outputs: []
    )

    public static func log__101(p0: EthAddress, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__101Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__101Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__101Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__102Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool],
        outputs: []
    )

    public static func log__102(p0: BigUInt, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__102Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__102Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__102Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__103Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .address],
        outputs: []
    )

    public static func log__103(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__103Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__103Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__103Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__104Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .string],
        outputs: []
    )

    public static func log__104(p0: Bool, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__104Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__104Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__104Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__105Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log__105(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__105Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__105Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__105Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__106Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .string],
        outputs: []
    )

    public static func log__106(p0: Bool, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__106Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__106Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__106Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__107Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string],
        outputs: []
    )

    public static func log__107(p0: String, p1: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__107Fn.encoded(with: [.string(p0), .string(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__107Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__107Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__108Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .uint256],
        outputs: []
    )

    public static func log__108(p0: Bool, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__108Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__108Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__108Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__109Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool],
        outputs: []
    )

    public static func log__109(p0: BigUInt, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__109Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__109Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__109Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__110Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log__110(p0: String, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__110Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__110Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__110Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__111Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool],
        outputs: []
    )

    public static func log__111(p0: Bool, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__111Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__111Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__111Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__112Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .bool],
        outputs: []
    )

    public static func log__112(p0: EthAddress, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__112Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__112Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__112Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__113Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .uint256],
        outputs: []
    )

    public static func log__113(p0: EthAddress, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__113Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__113Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__113Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__114Fn = ABI.Function(
        name: "log",
        inputs: [],
        outputs: []
    )

    public static func log__114(withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__114Fn.encoded(with: [])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__114Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__114Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__115Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .string],
        outputs: []
    )

    public static func log__115(p0: Bool, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__115Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__115Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__115Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__116Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .address],
        outputs: []
    )

    public static func log__116(p0: Bool, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__116Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__116Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__116Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__117Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .address],
        outputs: []
    )

    public static func log__117(p0: Bool, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__117Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__117Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__117Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__118Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .address],
        outputs: []
    )

    public static func log__118(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__118Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__118Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__118Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__119Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256],
        outputs: []
    )

    public static func log__119(p0: String, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__119Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__119Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__119Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__120Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string],
        outputs: []
    )

    public static func log__120(p0: String, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__120Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__120Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__120Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__121Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log__121(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__121Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__121Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__121Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__122Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .string],
        outputs: []
    )

    public static func log__122(p0: String, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__122Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__122Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__122Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__123Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256],
        outputs: []
    )

    public static func log__123(p0: BigUInt, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__123Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__123Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__123Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__124Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .string],
        outputs: []
    )

    public static func log__124(p0: String, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__124Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__124Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__124Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__125Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .uint256],
        outputs: []
    )

    public static func log__125(p0: BigUInt, p1: EthAddress, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__125Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__125Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__125Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__126Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .address],
        outputs: []
    )

    public static func log__126(p0: EthAddress, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__126Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__126Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__126Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__127Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address],
        outputs: []
    )

    public static func log__127(p0: BigUInt, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__127Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__127Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__127Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__128Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .bool],
        outputs: []
    )

    public static func log__128(p0: String, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__128Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__128Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__128Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__129Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .string],
        outputs: []
    )

    public static func log__129(p0: EthAddress, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__129Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__129Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__129Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__130Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .uint256],
        outputs: []
    )

    public static func log__130(p0: String, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__130Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__130Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__130Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__131Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .string],
        outputs: []
    )

    public static func log__131(p0: String, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__131Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__131Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__131Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__132Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log__132(p0: BigUInt, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__132Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__132Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__132Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__133Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .string],
        outputs: []
    )

    public static func log__133(p0: String, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__133Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__133Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__133Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__134Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .address],
        outputs: []
    )

    public static func log__134(p0: String, p1: BigUInt, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__134Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__134Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__134Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__135Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .bool],
        outputs: []
    )

    public static func log__135(p0: String, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__135Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__135Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__135Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__136Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .bool],
        outputs: []
    )

    public static func log__136(p0: EthAddress, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__136Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__136Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__136Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__137Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .bool],
        outputs: []
    )

    public static func log__137(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__137Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__137Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__137Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__138Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256],
        outputs: []
    )

    public static func log__138(p0: Bool, p1: EthAddress, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__138Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__138Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__138Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__139Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .address],
        outputs: []
    )

    public static func log__139(p0: BigUInt, p1: String, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__139Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__139Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__139Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__140Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log__140(p0: Bool, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__140Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__140Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__140Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__141Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256, .address],
        outputs: []
    )

    public static func log__141(p0: EthAddress, p1: String, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__141Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__141Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__141Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__142Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string],
        outputs: []
    )

    public static func log__142(p0: BigUInt, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__142Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__142Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__142Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__143Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .address],
        outputs: []
    )

    public static func log__143(p0: String, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__143Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__143Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__143Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__144Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string],
        outputs: []
    )

    public static func log__144(p0: BigUInt, p1: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__144Fn.encoded(with: [.uint256(p0), .string(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__144Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__144Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__145Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log__145(p0: String, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__145Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__145Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__145Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__146Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .address],
        outputs: []
    )

    public static func log__146(p0: EthAddress, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__146Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__146Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__146Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__147Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .address],
        outputs: []
    )

    public static func log__147(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__147Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__147Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__147Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__148Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log__148(p0: EthAddress, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__148Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__148Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__148Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__149Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool],
        outputs: []
    )

    public static func log__149(p0: EthAddress, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__149Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__149Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__149Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__150Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .uint256],
        outputs: []
    )

    public static func log__150(p0: EthAddress, p1: String, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__150Fn.encoded(with: [.address(p0), .string(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__150Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__150Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__151Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .string],
        outputs: []
    )

    public static func log__151(p0: BigUInt, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__151Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__151Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__151Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__152Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .bool],
        outputs: []
    )

    public static func log__152(p0: BigUInt, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__152Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__152Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__152Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__153Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address],
        outputs: []
    )

    public static func log__153(p0: BigUInt, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__153Fn.encoded(with: [.uint256(p0), .address(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__153Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__153Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__154Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .address],
        outputs: []
    )

    public static func log__154(p0: BigUInt, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__154Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__154Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__154Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__155Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log__155(p0: Bool, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__155Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__155Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__155Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__156Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .bool, .bool],
        outputs: []
    )

    public static func log__156(p0: Bool, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__156Fn.encoded(with: [.bool(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__156Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__156Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__157Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .uint256, .bool],
        outputs: []
    )

    public static func log__157(p0: Bool, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__157Fn.encoded(with: [.bool(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__157Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__157Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__158Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .string],
        outputs: []
    )

    public static func log__158(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__158Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__158Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__158Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__159Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .string],
        outputs: []
    )

    public static func log__159(p0: Bool, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__159Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__159Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__159Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__160Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .address],
        outputs: []
    )

    public static func log__160(p0: String, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__160Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__160Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__160Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__161Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log__161(p0: Bool, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__161Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__161Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__161Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__162Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .bool],
        outputs: []
    )

    public static func log__162(p0: Bool, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__162Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__162Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__162Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__163Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .bool],
        outputs: []
    )

    public static func log__163(p0: EthAddress, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__163Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__163Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__163Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__164Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .address],
        outputs: []
    )

    public static func log__164(p0: Bool, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__164Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__164Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__164Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__165Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .address],
        outputs: []
    )

    public static func log__165(p0: String, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__165Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__165Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__165Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__166Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string],
        outputs: []
    )

    public static func log__166(p0: BigUInt, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__166Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__166Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__166Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__167Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address, .uint256],
        outputs: []
    )

    public static func log__167(p0: BigUInt, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__167Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__167Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__167Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__168Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .string],
        outputs: []
    )

    public static func log__168(p0: String, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__168Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__168Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__168Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__169Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log__169(p0: BigUInt, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__169Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__169Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__169Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__170Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string],
        outputs: []
    )

    public static func log__170(p0: EthAddress, p1: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__170Fn.encoded(with: [.address(p0), .string(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__170Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__170Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__171Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool],
        outputs: []
    )

    public static func log__171(p0: EthAddress, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__171Fn.encoded(with: [.address(p0), .bool(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__171Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__171Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__172Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log__172(p0: String, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__172Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__172Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__172Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__173Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool, .bool],
        outputs: []
    )

    public static func log__173(p0: String, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__173Fn.encoded(with: [.string(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__173Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__173Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__174Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .string, .bool],
        outputs: []
    )

    public static func log__174(p0: BigUInt, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__174Fn.encoded(with: [.uint256(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__174Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__174Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__175Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address],
        outputs: []
    )

    public static func log__175(p0: BigUInt, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__175Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__175Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__175Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__176Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address],
        outputs: []
    )

    public static func log__176(p0: EthAddress, p1: BigUInt, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__176Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__176Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__176Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__177Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .uint256],
        outputs: []
    )

    public static func log__177(p0: Bool, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__177Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__177Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__177Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__178Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log__178(p0: Bool, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__178Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__178Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__178Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__179Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .address],
        outputs: []
    )

    public static func log__179(p0: String, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__179Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__179Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__179Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__180Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .uint256],
        outputs: []
    )

    public static func log__180(p0: String, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__180Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__180Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__180Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__181Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .bool],
        outputs: []
    )

    public static func log__181(p0: String, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__181Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__181Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__181Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__182Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .uint256, .string],
        outputs: []
    )

    public static func log__182(p0: Bool, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__182Fn.encoded(with: [.bool(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__182Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__182Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__183Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log__183(p0: Bool, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__183Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__183Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__183Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__184Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .string],
        outputs: []
    )

    public static func log__184(p0: String, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__184Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__184Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__184Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__185Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .string, .uint256],
        outputs: []
    )

    public static func log__185(p0: EthAddress, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__185Fn.encoded(with: [.address(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__185Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__185Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__186Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .bool],
        outputs: []
    )

    public static func log__186(p0: String, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__186Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__186Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__186Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__187Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log__187(p0: BigUInt, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__187Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__187Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__187Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__188Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256],
        outputs: []
    )

    public static func log__188(p0: EthAddress, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__188Fn.encoded(with: [.address(p0), .uint256(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__188Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__188Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__189Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool],
        outputs: []
    )

    public static func log__189(p0: String, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__189Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__189Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__189Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__190Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address],
        outputs: []
    )

    public static func log__190(p0: Bool, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__190Fn.encoded(with: [.bool(p0), .address(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__190Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__190Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__191Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log__191(p0: String, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__191Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__191Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__191Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__192Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string],
        outputs: []
    )

    public static func log__192(p0: BigUInt, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__192Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__192Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__192Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__193Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .string],
        outputs: []
    )

    public static func log__193(p0: EthAddress, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__193Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__193Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__193Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__194Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .address],
        outputs: []
    )

    public static func log__194(p0: BigUInt, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__194Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__194Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__194Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__195Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .address, .uint256],
        outputs: []
    )

    public static func log__195(p0: BigUInt, p1: BigUInt, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__195Fn.encoded(with: [.uint256(p0), .uint256(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__195Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__195Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__196Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .bool],
        outputs: []
    )

    public static func log__196(p0: String, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__196Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__196Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__196Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__197Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log__197(p0: String, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__197Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__197Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__197Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__198Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .bool, .address],
        outputs: []
    )

    public static func log__198(p0: Bool, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__198Fn.encoded(with: [.bool(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__198Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__198Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__199Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log__199(p0: EthAddress, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__199Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__199Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__199Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__200Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .address],
        outputs: []
    )

    public static func log__200(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__200Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__200Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__200Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__201Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .uint256],
        outputs: []
    )

    public static func log__201(p0: String, p1: Bool, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__201Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__201Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__201Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__202Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .string],
        outputs: []
    )

    public static func log__202(p0: Bool, p1: BigUInt, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__202Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__202Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__202Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__203Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .uint256],
        outputs: []
    )

    public static func log__203(p0: String, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__203Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__203Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__203Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__204Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .uint256],
        outputs: []
    )

    public static func log__204(p0: String, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__204Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__204Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__204Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__205Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .address],
        outputs: []
    )

    public static func log__205(p0: EthAddress, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__205Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__205Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__205Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__206Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string],
        outputs: []
    )

    public static func log__206(p0: Bool, p1: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__206Fn.encoded(with: [.bool(p0), .string(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__206Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__206Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__207Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .bool],
        outputs: []
    )

    public static func log__207(p0: BigUInt, p1: String, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__207Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__207Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__207Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__208Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .string],
        outputs: []
    )

    public static func log__208(p0: BigUInt, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__208Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__208Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__208Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__209Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .string],
        outputs: []
    )

    public static func log__209(p0: Bool, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__209Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__209Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__209Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__210Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log__210(p0: BigUInt, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__210Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__210Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__210Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__211Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .uint256],
        outputs: []
    )

    public static func log__211(p0: String, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__211Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__211Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__211Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__212Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address],
        outputs: []
    )

    public static func log__212(p0: String, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__212Fn.encoded(with: [.string(p0), .bool(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__212Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__212Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__213Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256, .address],
        outputs: []
    )

    public static func log__213(p0: String, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__213Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__213Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__213Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__214Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .uint256],
        outputs: []
    )

    public static func log__214(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__214Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__214Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__214Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__215Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .address, .bool],
        outputs: []
    )

    public static func log__215(p0: String, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__215Fn.encoded(with: [.string(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__215Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__215Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__216Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address],
        outputs: []
    )

    public static func log__216(p0: Bool, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__216Fn.encoded(with: [.bool(p0), .string(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__216Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__216Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__217Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address],
        outputs: []
    )

    public static func log__217(p0: String, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__217Fn.encoded(with: [.string(p0), .string(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__217Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__217Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__218Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string, .address],
        outputs: []
    )

    public static func log__218(p0: Bool, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__218Fn.encoded(with: [.bool(p0), .string(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__218Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__218Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__219Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .address],
        outputs: []
    )

    public static func log__219(p0: BigUInt, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__219Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__219Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__219Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__220Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .address],
        outputs: []
    )

    public static func log__220(p0: Bool, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__220Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__220Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__220Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__221Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .bool],
        outputs: []
    )

    public static func log__221(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__221Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__221Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__221Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__222Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool],
        outputs: []
    )

    public static func log__222(p0: BigUInt, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__222Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__222Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__222Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__223Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .string],
        outputs: []
    )

    public static func log__223(p0: BigUInt, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__223Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__223Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__223Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__224Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256],
        outputs: []
    )

    public static func log__224(p0: EthAddress, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__224Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__224Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__224Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__225Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .address],
        outputs: []
    )

    public static func log__225(p0: BigUInt, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__225Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__225Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__225Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__226Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .bool, .string],
        outputs: []
    )

    public static func log__226(p0: String, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__226Fn.encoded(with: [.string(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__226Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__226Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__227Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .address],
        outputs: []
    )

    public static func log__227(p0: EthAddress, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__227Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__227Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__227Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__228Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .address, .string],
        outputs: []
    )

    public static func log__228(p0: String, p1: BigUInt, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__228Fn.encoded(with: [.string(p0), .uint256(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__228Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__228Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__229Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string, .address],
        outputs: []
    )

    public static func log__229(p0: EthAddress, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__229Fn.encoded(with: [.address(p0), .string(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__229Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__229Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__230Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .string],
        outputs: []
    )

    public static func log__230(p0: Bool, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__230Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__230Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__230Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__231Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .address, .bool],
        outputs: []
    )

    public static func log__231(p0: EthAddress, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__231Fn.encoded(with: [.address(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__231Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__231Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__232Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .address],
        outputs: []
    )

    public static func log__232(p0: BigUInt, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__232Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__232Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__232Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__233Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string],
        outputs: []
    )

    public static func log__233(p0: EthAddress, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__233Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__233Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__233Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__234Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .address],
        outputs: []
    )

    public static func log__234(p0: EthAddress, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__234Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__234Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__234Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__235Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .string],
        outputs: []
    )

    public static func log__235(p0: BigUInt, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__235Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__235Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__235Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__236Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .address, .uint256],
        outputs: []
    )

    public static func log__236(p0: Bool, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__236Fn.encoded(with: [.bool(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__236Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__236Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__237Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .bool],
        outputs: []
    )

    public static func log__237(p0: EthAddress, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__237Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__237Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__237Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__238Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .string],
        outputs: []
    )

    public static func log__238(p0: Bool, p1: EthAddress, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__238Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__238Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__238Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__239Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address, .uint256],
        outputs: []
    )

    public static func log__239(p0: EthAddress, p1: Bool, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__239Fn.encoded(with: [.address(p0), .bool(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__239Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__239Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__240Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log__240(p0: String, p1: BigUInt, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__240Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__240Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__240Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__241Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .string],
        outputs: []
    )

    public static func log__241(p0: String, p1: Bool, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__241Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__241Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__241Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__242Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool, .string],
        outputs: []
    )

    public static func log__242(p0: EthAddress, p1: EthAddress, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__242Fn.encoded(with: [.address(p0), .address(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__242Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__242Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__243Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string, .address],
        outputs: []
    )

    public static func log__243(p0: String, p1: EthAddress, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__243Fn.encoded(with: [.string(p0), .address(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__243Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__243Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__244Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log__244(p0: BigUInt, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__244Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__244Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__244Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__245Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .string],
        outputs: []
    )

    public static func log__245(p0: String, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__245Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__245Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__245Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__246Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .address, .string],
        outputs: []
    )

    public static func log__246(p0: BigUInt, p1: Bool, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__246Fn.encoded(with: [.uint256(p0), .bool(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__246Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__246Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__247Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .address],
        outputs: []
    )

    public static func log__247(p0: BigUInt, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__247Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__247Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__247Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__248Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .uint256],
        outputs: []
    )

    public static func log__248(p0: BigUInt, p1: String, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__248Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__248Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__248Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__249Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .string],
        outputs: []
    )

    public static func log__249(p0: Bool, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__249Fn.encoded(with: [.bool(p0), .string(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__249Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__249Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__250Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool],
        outputs: []
    )

    public static func log__250(p0: String, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__250Fn.encoded(with: [.string(p0), .string(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__250Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__250Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__251Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string],
        outputs: []
    )

    public static func log__251(p0: BigUInt, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__251Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__251Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__251Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__252Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .bool],
        outputs: []
    )

    public static func log__252(p0: BigUInt, p1: String, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__252Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__252Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__252Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__253Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .address, .bool],
        outputs: []
    )

    public static func log__253(p0: Bool, p1: BigUInt, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__253Fn.encoded(with: [.bool(p0), .uint256(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__253Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__253Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__254Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .bool],
        outputs: []
    )

    public static func log__254(p0: String, p1: EthAddress, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__254Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__254Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__254Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__255Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256],
        outputs: []
    )

    public static func log__255(p0: String, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__255Fn.encoded(with: [.string(p0), .uint256(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__255Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__255Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__256Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .uint256],
        outputs: []
    )

    public static func log__256(p0: EthAddress, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__256Fn.encoded(with: [.address(p0), .uint256(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__256Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__256Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__257Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .bool],
        outputs: []
    )

    public static func log__257(p0: BigUInt, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__257Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__257Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__257Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__258Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .uint256, .string],
        outputs: []
    )

    public static func log__258(p0: BigUInt, p1: String, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__258Fn.encoded(with: [.uint256(p0), .string(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__258Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__258Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__259Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .bool],
        outputs: []
    )

    public static func log__259(p0: Bool, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__259Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__259Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__259Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__260Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .bool],
        outputs: []
    )

    public static func log__260(p0: BigUInt, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__260Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__260Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__260Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__261Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool, .string],
        outputs: []
    )

    public static func log__261(p0: EthAddress, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__261Fn.encoded(with: [.address(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__261Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__261Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__262Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .address],
        outputs: []
    )

    public static func log__262(p0: BigUInt, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__262Fn.encoded(with: [.uint256(p0), .address(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__262Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__262Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__263Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log__263(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__263Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__263Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__263Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__264Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log__264(p0: Bool, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__264Fn.encoded(with: [.bool(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__264Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__264Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__265Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log__265(p0: EthAddress, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__265Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__265Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__265Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__266Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .bool],
        outputs: []
    )

    public static func log__266(p0: Bool, p1: Bool, p2: EthAddress, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__266Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__266Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__266Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__267Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .uint256],
        outputs: []
    )

    public static func log__267(p0: Bool, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__267Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__267Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__267Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__268Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .address],
        outputs: []
    )

    public static func log__268(p0: String, p1: String, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__268Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__268Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__268Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__269Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .bool],
        outputs: []
    )

    public static func log__269(p0: String, p1: String, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__269Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__269Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__269Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__270Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool],
        outputs: []
    )

    public static func log__270(p0: String, p1: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__270Fn.encoded(with: [.string(p0), .bool(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__270Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__270Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__271Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string],
        outputs: []
    )

    public static func log__271(p0: Bool, p1: BigUInt, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__271Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__271Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__271Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__272Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .bool],
        outputs: []
    )

    public static func log__272(p0: EthAddress, p1: Bool, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__272Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__272Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__272Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__273Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .bool],
        outputs: []
    )

    public static func log__273(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__273Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__273Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__273Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__274Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .bool, .string],
        outputs: []
    )

    public static func log__274(p0: EthAddress, p1: BigUInt, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__274Fn.encoded(with: [.address(p0), .uint256(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__274Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__274Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__275Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .string, .uint256],
        outputs: []
    )

    public static func log__275(p0: String, p1: BigUInt, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__275Fn.encoded(with: [.string(p0), .uint256(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__275Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__275Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__276Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .uint256],
        outputs: []
    )

    public static func log__276(p0: BigUInt, p1: Bool, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__276Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__276Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__276Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__277Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .bool],
        outputs: []
    )

    public static func log__277(p0: String, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__277Fn.encoded(with: [.string(p0), .address(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__277Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__277Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__278Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .uint256],
        outputs: []
    )

    public static func log__278(p0: String, p1: Bool, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__278Fn.encoded(with: [.string(p0), .bool(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__278Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__278Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__279Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256],
        outputs: []
    )

    public static func log__279(p0: String, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__279Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__279Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__279Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__280Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool],
        outputs: []
    )

    public static func log__280(p0: String, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__280Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__280Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__280Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__281Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .bool],
        outputs: []
    )

    public static func log__281(p0: EthAddress, p1: Bool, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__281Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__281Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__281Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__282Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .string, .bool],
        outputs: []
    )

    public static func log__282(p0: BigUInt, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__282Fn.encoded(with: [.uint256(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__282Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__282Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__283Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .uint256, .address],
        outputs: []
    )

    public static func log__283(p0: EthAddress, p1: Bool, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__283Fn.encoded(with: [.address(p0), .bool(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__283Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__283Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__284Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool, .bool],
        outputs: []
    )

    public static func log__284(p0: Bool, p1: BigUInt, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__284Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__284Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__284Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__285Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .uint256],
        outputs: []
    )

    public static func log__285(p0: BigUInt, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__285Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__285Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__285Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__286Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .bool],
        outputs: []
    )

    public static func log__286(p0: EthAddress, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__286Fn.encoded(with: [.address(p0), .string(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__286Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__286Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__287Fn = ABI.Function(
        name: "log",
        inputs: [.address, .uint256, .string, .bool],
        outputs: []
    )

    public static func log__287(p0: EthAddress, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__287Fn.encoded(with: [.address(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__287Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__287Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__288Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .address],
        outputs: []
    )

    public static func log__288(p0: EthAddress, p1: Bool, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__288Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__288Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__288Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__289Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256],
        outputs: []
    )

    public static func log__289(p0: BigUInt, p1: BigUInt, p2: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__289Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__289Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__289Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__290Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address],
        outputs: []
    )

    public static func log__290(p0: Bool, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__290Fn.encoded(with: [.bool(p0), .address(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__290Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__290Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__291Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .bool, .string],
        outputs: []
    )

    public static func log__291(p0: BigUInt, p1: String, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__291Fn.encoded(with: [.uint256(p0), .string(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__291Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__291Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__292Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .string, .address],
        outputs: []
    )

    public static func log__292(p0: BigUInt, p1: String, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__292Fn.encoded(with: [.uint256(p0), .string(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__292Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__292Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__293Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .uint256, .bool],
        outputs: []
    )

    public static func log__293(p0: Bool, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__293Fn.encoded(with: [.bool(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__293Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__293Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__294Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .bool, .uint256],
        outputs: []
    )

    public static func log__294(p0: String, p1: String, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__294Fn.encoded(with: [.string(p0), .string(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__294Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__294Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__295Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .address, .string],
        outputs: []
    )

    public static func log__295(p0: Bool, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__295Fn.encoded(with: [.bool(p0), .address(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__295Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__295Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__296Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address],
        outputs: []
    )

    public static func log__296(p0: EthAddress, p1: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__296Fn.encoded(with: [.address(p0), .address(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__296Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__296Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__297Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool],
        outputs: []
    )

    public static func log__297(p0: Bool, p1: String, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__297Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__297Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__297Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__298Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .string, .bool, .bool],
        outputs: []
    )

    public static func log__298(p0: Bool, p1: String, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__298Fn.encoded(with: [.bool(p0), .string(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__298Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__298Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__299Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .uint256, .string],
        outputs: []
    )

    public static func log__299(p0: BigUInt, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__299Fn.encoded(with: [.uint256(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__299Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__299Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__300Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .bool, .string],
        outputs: []
    )

    public static func log__300(p0: BigUInt, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__300Fn.encoded(with: [.uint256(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__300Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__300Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__301Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .uint256, .string],
        outputs: []
    )

    public static func log__301(p0: BigUInt, p1: Bool, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__301Fn.encoded(with: [.uint256(p0), .bool(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__301Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__301Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__302Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .string, .string],
        outputs: []
    )

    public static func log__302(p0: String, p1: String, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__302Fn.encoded(with: [.string(p0), .string(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__302Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__302Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__303Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string],
        outputs: []
    )

    public static func log__303(p0: Bool, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__303Fn.encoded(with: [.bool(p0), .address(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__303Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__303Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__304Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool, .string],
        outputs: []
    )

    public static func log__304(p0: EthAddress, p1: Bool, p2: Bool, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__304Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__304Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__304Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__305Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string, .address],
        outputs: []
    )

    public static func log__305(p0: String, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__305Fn.encoded(with: [.string(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__305Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__305Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__306Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .address],
        outputs: []
    )

    public static func log__306(p0: String, p1: BigUInt, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__306Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__306Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__306Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__307Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .string],
        outputs: []
    )

    public static func log__307(p0: String, p1: EthAddress, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__307Fn.encoded(with: [.string(p0), .address(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__307Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__307Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__308Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log__308(p0: String, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__308Fn.encoded(with: [.string(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__308Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__308Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__309Fn = ABI.Function(
        name: "log",
        inputs: [.string, .bool, .string],
        outputs: []
    )

    public static func log__309(p0: String, p1: Bool, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__309Fn.encoded(with: [.string(p0), .bool(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__309Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__309Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__310Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .address, .string, .bool],
        outputs: []
    )

    public static func log__310(p0: Bool, p1: EthAddress, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__310Fn.encoded(with: [.bool(p0), .address(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__310Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__310Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__311Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .bool],
        outputs: []
    )

    public static func log__311(p0: BigUInt, p1: EthAddress, p2: Bool, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__311Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__311Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__311Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__312Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .uint256],
        outputs: []
    )

    public static func log__312(p0: Bool, p1: Bool, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__312Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__312Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__312Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__313Fn = ABI.Function(
        name: "log",
        inputs: [.string, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log__313(p0: String, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__313Fn.encoded(with: [.string(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__313Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__313Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__314Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .bool],
        outputs: []
    )

    public static func log__314(p0: Bool, p1: BigUInt, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__314Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__314Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__314Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__315Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .string, .address, .uint256],
        outputs: []
    )

    public static func log__315(p0: BigUInt, p1: String, p2: EthAddress, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__315Fn.encoded(with: [.uint256(p0), .string(p1), .address(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__315Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__315Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__316Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .bool],
        outputs: []
    )

    public static func log__316(p0: Bool, p1: BigUInt, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__316Fn.encoded(with: [.bool(p0), .uint256(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__316Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__316Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__317Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .address, .string],
        outputs: []
    )

    public static func log__317(p0: String, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__317Fn.encoded(with: [.string(p0), .string(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__317Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__317Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__318Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .bool, .uint256],
        outputs: []
    )

    public static func log__318(p0: BigUInt, p1: BigUInt, p2: Bool, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__318Fn.encoded(with: [.uint256(p0), .uint256(p1), .bool(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__318Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__318Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__319Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .bool],
        outputs: []
    )

    public static func log__319(p0: EthAddress, p1: Bool, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__319Fn.encoded(with: [.address(p0), .bool(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__319Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__319Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__320Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .bool],
        outputs: []
    )

    public static func log__320(p0: BigUInt, p1: Bool, p2: String, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__320Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__320Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__320Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__321Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address, .address],
        outputs: []
    )

    public static func log__321(p0: String, p1: EthAddress, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__321Fn.encoded(with: [.string(p0), .address(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__321Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__321Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__322Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .string, .uint256],
        outputs: []
    )

    public static func log__322(p0: EthAddress, p1: EthAddress, p2: String, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__322Fn.encoded(with: [.address(p0), .address(p1), .string(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__322Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__322Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__323Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .bool, .string, .address],
        outputs: []
    )

    public static func log__323(p0: BigUInt, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__323Fn.encoded(with: [.uint256(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__323Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__323Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__324Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .address, .bool, .address],
        outputs: []
    )

    public static func log__324(p0: BigUInt, p1: EthAddress, p2: Bool, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__324Fn.encoded(with: [.uint256(p0), .address(p1), .bool(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__324Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__324Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__325Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address],
        outputs: []
    )

    public static func log__325(p0: EthAddress, p1: String, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__325Fn.encoded(with: [.address(p0), .string(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__325Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__325Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__326Fn = ABI.Function(
        name: "log",
        inputs: [.address, .bool, .address],
        outputs: []
    )

    public static func log__326(p0: EthAddress, p1: Bool, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__326Fn.encoded(with: [.address(p0), .bool(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__326Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__326Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__327Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .bool],
        outputs: []
    )

    public static func log__327(p0: EthAddress, p1: EthAddress, p2: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__327Fn.encoded(with: [.address(p0), .address(p1), .bool(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__327Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__327Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__328Fn = ABI.Function(
        name: "log",
        inputs: [.string, .string, .uint256, .uint256],
        outputs: []
    )

    public static func log__328(p0: String, p1: String, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__328Fn.encoded(with: [.string(p0), .string(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__328Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__328Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__329Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .address, .address],
        outputs: []
    )

    public static func log__329(p0: Bool, p1: Bool, p2: EthAddress, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__329Fn.encoded(with: [.bool(p0), .bool(p1), .address(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__329Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__329Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__330Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .string],
        outputs: []
    )

    public static func log__330(p0: Bool, p1: BigUInt, p2: String, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__330Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__330Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__330Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__331Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256],
        outputs: []
    )

    public static func log__331(p0: BigUInt, p1: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__331Fn.encoded(with: [.uint256(p0), .uint256(p1)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__331Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__331Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__332Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .address, .string],
        outputs: []
    )

    public static func log__332(p0: EthAddress, p1: String, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__332Fn.encoded(with: [.address(p0), .string(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__332Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__332Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__333Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .address, .string],
        outputs: []
    )

    public static func log__333(p0: EthAddress, p1: EthAddress, p2: EthAddress, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__333Fn.encoded(with: [.address(p0), .address(p1), .address(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__333Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__333Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__334Fn = ABI.Function(
        name: "log",
        inputs: [.uint256],
        outputs: []
    )

    public static func log__334(p0: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__334Fn.encoded(with: [.uint256(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__334Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__334Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__335Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .uint256],
        outputs: []
    )

    public static func log__335(p0: String, p1: EthAddress, p2: BigUInt, p3: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__335Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .uint256(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__335Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__335Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__336Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .bool, .string, .address],
        outputs: []
    )

    public static func log__336(p0: Bool, p1: Bool, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__336Fn.encoded(with: [.bool(p0), .bool(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__336Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__336Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__337Fn = ABI.Function(
        name: "log",
        inputs: [.uint256, .uint256, .uint256, .address],
        outputs: []
    )

    public static func log__337(p0: BigUInt, p1: BigUInt, p2: BigUInt, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__337Fn.encoded(with: [.uint256(p0), .uint256(p1), .uint256(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__337Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__337Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__338Fn = ABI.Function(
        name: "log",
        inputs: [.address, .string, .string],
        outputs: []
    )

    public static func log__338(p0: EthAddress, p1: String, p2: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__338Fn.encoded(with: [.address(p0), .string(p1), .string(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__338Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__338Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__339Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .uint256, .bool],
        outputs: []
    )

    public static func log__339(p0: String, p1: EthAddress, p2: BigUInt, p3: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__339Fn.encoded(with: [.string(p0), .address(p1), .uint256(p2), .bool(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__339Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__339Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__340Fn = ABI.Function(
        name: "log",
        inputs: [.string, .address, .address],
        outputs: []
    )

    public static func log__340(p0: String, p1: EthAddress, p2: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__340Fn.encoded(with: [.string(p0), .address(p1), .address(p2)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__340Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__340Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__341Fn = ABI.Function(
        name: "log",
        inputs: [.address, .address, .uint256, .string],
        outputs: []
    )

    public static func log__341(p0: EthAddress, p1: EthAddress, p2: BigUInt, p3: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__341Fn.encoded(with: [.address(p0), .address(p1), .uint256(p2), .string(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__341Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__341Fn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static let log__342Fn = ABI.Function(
        name: "log",
        inputs: [.bool, .uint256, .string, .address],
        outputs: []
    )

    public static func log__342(p0: Bool, p1: BigUInt, p2: String, p3: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try log__342Fn.encoded(with: [.bool(p0), .uint256(p1), .string(p2), .address(p3)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try log__342Fn.decode(output: result)

            switch decoded {
            case .tuple0:
                return .success(())
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, log__342Fn.outputTuple)
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

    public static func logAddress(p0: EthAddress, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logAddressFn.encoded(with: [.address(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBool(p0: Bool, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBoolFn.encoded(with: [.bool(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytesFn.encoded(with: [.bytes(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes1(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes1Fn.encoded(with: [.bytes1(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes10(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes10Fn.encoded(with: [.bytes10(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes11(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes11Fn.encoded(with: [.bytes11(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes12(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes12Fn.encoded(with: [.bytes12(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes13(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes13Fn.encoded(with: [.bytes13(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes14(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes14Fn.encoded(with: [.bytes14(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes15(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes15Fn.encoded(with: [.bytes15(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes16(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes16Fn.encoded(with: [.bytes16(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes17(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes17Fn.encoded(with: [.bytes17(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes18(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes18Fn.encoded(with: [.bytes18(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes19(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes19Fn.encoded(with: [.bytes19(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes2(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes2Fn.encoded(with: [.bytes2(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes20(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes20Fn.encoded(with: [.bytes20(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes21(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes21Fn.encoded(with: [.bytes21(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes22(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes22Fn.encoded(with: [.bytes22(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes23(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes23Fn.encoded(with: [.bytes23(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes24(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes24Fn.encoded(with: [.bytes24(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes25(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes25Fn.encoded(with: [.bytes25(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes26(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes26Fn.encoded(with: [.bytes26(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes27(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes27Fn.encoded(with: [.bytes27(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes28(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes28Fn.encoded(with: [.bytes28(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes29(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes29Fn.encoded(with: [.bytes29(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes3(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes3Fn.encoded(with: [.bytes3(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes30(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes30Fn.encoded(with: [.bytes30(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes31(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes31Fn.encoded(with: [.bytes31(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes32(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes32Fn.encoded(with: [.bytes32(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes4(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes4Fn.encoded(with: [.bytes4(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes5(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes5Fn.encoded(with: [.bytes5(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes6(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes6Fn.encoded(with: [.bytes6(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes7(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes7Fn.encoded(with: [.bytes7(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes8(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes8Fn.encoded(with: [.bytes8(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logBytes9(p0: Hex, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logBytes9Fn.encoded(with: [.bytes9(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logInt(p0: BigInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logIntFn.encoded(with: [.int256(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logString(p0: String, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logStringFn.encoded(with: [.string(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func logUint(p0: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) throws -> Result<Void, RevertReason> {
        do {
            let query = try logUintFn.encoded(with: [.uint256(p0)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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
