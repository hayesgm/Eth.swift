import Foundation
import SwiftKeccak
import SwiftNumber

public enum EVM {
    static let maxUint256 = Number(1) << 256
    static let maxInt256 = SNumber(1) << 256
    static let one = Number(1)
    static let sZero = SNumber(0)
    static let sOne = SNumber(1)
    static let wordZero = EthWord(fromSNumber: .zero)!
    static let wordOne = EthWord(fromNumber: one)!
    static let gasAmount = EthWord(fromInt: 4_000_000)!

    private static func consoleFFI(args: Hex) -> EVM.FFIResult {
        let consoleFns: [ABI.Function] = IConsole.functions
        let logFnDict = Dictionary(consoleFns.map { ($0.signatureHash, $0) }, uniquingKeysWith: { first, _ in first })
        if args.count >= 4, let logCall = logFnDict[Hex(args.data.subdata(in: 0 ..< 4))] {
            // Note: this decoding shouldn't fail if the contract is from proper Solidity, but it's always possible,
            //       and so we'll default to a standard revert in such a case.
            if let value = try? logCall.decodeInput(input: args) {
                print("Console.log: \(value.description)")
            }
        }
        return .ok("0x")
    }

    static let defaultFFIs: FFIMap = [
        "0x000000000000000000636F6e736F6c652e6c6f67": consoleFFI,
    ]

    /**
     An enumeration of errors that can occur during VM execution.

     - stackUnderflow: Attempted to read data that did not exist on stack
     - stackOverflow: 1024 or more items attempted to be stored on stack
     - pcOutOfBounds: PC moved to a region of non-executable code. Note: may occur after an `INVALID` instruction.
     - invalidJumpDest: `JUMP` or `JUMPI` did not move to a valid `JUMPDEST` code location.
     - outOfMemory: Memory expanded beyond reasonable limits.
     - invalidOperation: The `INVALID` instruction was executed.
     - impure: The EVM only supports `pure` instructions (that is, ones that do not read any blockchain state). Such an impure instruction was executed.
     - notImplemented: An instruction that is not currently supported was executed.
     - unexpectedError: An unexpected error occurred. These are for truly exceptional events that should not occur.
     */
    public enum VMError: Error, Equatable {
        case stackUnderflow
        case stackOverflow
        case pcOutOfBounds
        case invalidJumpDest
        case outOfMemory
        case invalidOperation
        case impure(Operation)
        case notImplemented(Operation)
        case noSuchFFI(EthAddress)
        case unexpectedError(String)
    }

    /**
     An enumeration of possible results from an FFI function call

     - ok: The FFI succeeded and returned the given bytes
     - revert: The FFI reverted and returned the given error bytes
     */
    public enum FFIResult: Error, Equatable, Sendable {
        case ok(Hex)
        case revert(Hex)
    }

    /**
      Errors that occur when decoding EVM assembly code from opcodes.

      - outOfBounds: Code ran outside of bounds, e.g. a `PUSH32` with insufficient data
      - invalidOpcode: An unassigned opcode was reached. May be due to an upgraded EVM chain.
     */
    public enum CodeError: Error, Equatable {
        case outOfBounds
        case invalidOpcode(UInt8)
    }

    /// Inputs to an EVM call. That is, the `calldata` and ETH `value`.
    public struct CallInput: Sendable {
        public let calldata: Hex
        public let value: Number

        /// Reads data from the call input with zero padding if necessary.
        /// - Parameters:
        ///   - offset: The starting point to read the data.
        ///   - bytes: The number of bytes to read.
        /// - Returns: The requested data with zero padding if out of bounds.
        func readData(offset: Int, bytes: Int) -> Data {
            EVM.readZeroPaddedData(offset: offset, bytes: bytes, fromData: calldata.data)
        }
    }

    private static func readZeroPaddedData(offset: Int, bytes sz: Int, fromData data: Data) -> Data {
        let paddingSize = (offset + sz) - data.count
        let padding: Data
        if paddingSize > 0 {
            padding = Data(repeating: 0, count: paddingSize)
        } else {
            padding = Data()
        }
        let paddedData = data + padding
        return paddedData.subdata(in: offset ..< (offset + sz))
    }

    /// An alias for an array of `Operation`s representing an executable EVM program.
    public typealias Code = [Operation]

    /// A structure to store the VM stack during execution of an EVM program.
    public typealias Stack = [EthWord]

    public typealias FFIMap = [EthAddress: @Sendable (Hex) -> FFIResult]

    struct Context: Sendable {
        var pc: Int = 0
        var stack: Stack = []
        var memory: Data = .init()
        var halted: Bool = false
        var reverted: Bool = false
        var returnData: Data = .init()
        var tStorage: [EthWord: EthWord] = [:]
        let code: Code
        var opMap: [Int: Operation]
        var ffis: FFIMap

        /// Initializes the EVM context with the provided code.
        /// - Parameter code: The code to execute in the EVM.
        /// - Parameter ffis: The FFIs avaiable to the runtime environment
        init(withCode code: Code, withFunctions ffis: FFIMap) {
            self.code = code
            self.ffis = ffis
            opMap = Context.buildOpMap(code: code)
        }

        var codeEncoded: Hex {
            encodeCode(code)
        }

        var description: String {
            let operation = "\u{1b}[33m" + (getOperation()?.description ?? "UNK") + "\u{1b}[39m"
            let showStack = stack.count == 0 ? "[Empty]" : stack.map { $0.description }.joined(separator: "\n\t\t")
            let showMemory = EthUtil.showChunkedWords(memory)
            return " [pc=\(pc)] \(operation)\n\n\tStack\n\t╰ Top\n\t\t\(showStack)\n\n\tMemory\n\t╰\n\t\t\(showMemory)\n\n"
        }

        private static func buildOpMap(code: Code) -> [Int: Operation] {
            var pc = 0
            var opMap: [Int: Operation] = [:]
            for operation in code {
                opMap[pc] = operation
                pc += operation.size
            }
            return opMap
        }

        func getOperation() -> Operation? {
            opMap[pc]
        }

        mutating func pop() throws -> (EthWord) {
            guard stack.count >= 1 else {
                throw VMError.stackUnderflow
            }
            let a: EthWord = stack.removeFirst()
            return a
        }

        mutating func pop2() throws -> (EthWord, EthWord) {
            guard stack.count >= 2 else {
                throw VMError.stackUnderflow
            }
            let a: EthWord = stack.removeFirst()
            let b: EthWord = stack.removeFirst()
            return (a, b)
        }

        mutating func pop3() throws -> (EthWord, EthWord, EthWord) {
            guard stack.count >= 3 else {
                throw VMError.stackUnderflow
            }
            let a: EthWord = stack.removeFirst()
            let b: EthWord = stack.removeFirst()
            let c: EthWord = stack.removeFirst()
            return (a, b, c)
        }

        mutating func peek(_ x: Int) throws -> EthWord {
            guard stack.count >= x else {
                throw VMError.stackUnderflow
            }
            return stack[x]
        }

        mutating func swap(_ a: Int, _ b: Int) throws {
            guard stack.count >= b, stack.count >= b else {
                throw VMError.stackUnderflow
            }
            stack.swapAt(a, b)
        }

        mutating func push(_ x: EthWord) throws {
            guard stack.count < 1024 else {
                throw VMError.stackOverflow
            }
            stack.insert(x, at: 0)
        }

        mutating func incrementPC(operation: Operation) {
            pc = pc + operation.size
        }

        mutating func memoryExpand(to sz: Int) throws {
            let paddingSize = sz - memory.count
            if paddingSize > 0 {
                let padding = Data(repeating: 0, count: paddingSize)
                memory += padding
            }
        }

        mutating func memoryRead(offset: Int, bytes sz: Int) throws -> Data {
            try memoryExpand(to: offset + sz)

            guard offset >= 0, sz >= 0, offset + sz <= memory.count else {
                throw VMError.outOfMemory
            }

            return memory.subdata(in: offset ..< (offset + sz))
        }

        mutating func memoryWrite(offset: Int, value: Data) throws {
            try memoryExpand(to: offset + value.count)

            guard offset >= 0, offset + value.count <= memory.count else {
                throw VMError.outOfMemory
            }

            memory.replaceSubrange(offset ..< (offset + value.count), with: value)
        }
    }

    /// The results of an EVM execution.
    public struct ExecutionResult: Equatable {
        /// The final stack when the program stopped (e.g. via `STOP`, `REVERT` or `RETURN`)
        public let stack: Stack

        /// Whether or not the program stopped due to a `REVERT` operation.
        public let reverted: Bool

        /// The `returnData` from either a `RETURN` or `REVERT`. See the `reverted` flag to determine which.
        public let returnData: Hex
    }

    /// A mapping of all known EVM operations.
    public enum Operation: Equatable, Sendable {
        case stop
        case add
        case sub
        case mul
        case div
        case sdiv
        case mod
        case smod
        case addmod
        case mulmod
        case exp
        case signextend
        case lt
        case gt
        case slt
        case sgt
        case eq
        case iszero
        case and
        case or
        case xor
        case not
        case byte
        case shl
        case shr
        case sar
        case keccak256
        case address
        case balance
        case origin
        case caller
        case callvalue
        case calldataload
        case calldatasize
        case calldatacopy
        case codesize
        case codecopy
        case gasprice
        case extcodesize
        case extcodecopy
        case returndatasize
        case returndatacopy
        case extcodehash
        case blockhash
        case coinbase
        case timestamp
        case number
        case prevrandao
        case gaslimit
        case chainid
        case selfbalance
        case basefee
        case blobhash
        case blobbasefee
        case pop
        case mload
        case mstore
        case mstore8
        case sload
        case sstore
        case jump
        case jumpi
        case pc
        case msize
        case gas
        case jumpdest
        case tload
        case tstore
        case mcopy
        case push(Int, EthWord)
        case dup(Int)
        case swap(Int)
        case log(Int)
        case create
        case call
        case callcode
        case `return`
        case delegatecall
        case create2
        case staticcall
        case revert
        case invalid(Hex)
        case selfdestruct

        public var description: String {
            switch self {
            case .stop:
                return "stop"
            case .add:
                return "add"
            case .sub:
                return "sub"
            case .mul:
                return "mul"
            case .div:
                return "div"
            case .sdiv:
                return "sdiv"
            case .mod:
                return "mod"
            case .smod:
                return "smod"
            case .addmod:
                return "addmod"
            case .mulmod:
                return "mulmod"
            case .exp:
                return "exp"
            case .signextend:
                return "signextend"
            case .lt:
                return "lt"
            case .gt:
                return "gt"
            case .slt:
                return "slt"
            case .sgt:
                return "sgt"
            case .eq:
                return "eq"
            case .iszero:
                return "iszero"
            case .and:
                return "and"
            case .or:
                return "or"
            case .xor:
                return "xor"
            case .not:
                return "not"
            case .byte:
                return "byte"
            case .shl:
                return "shl"
            case .shr:
                return "shr"
            case .sar:
                return "sar"
            case .keccak256:
                return "keccak256"
            case .address:
                return "address"
            case .balance:
                return "balance"
            case .origin:
                return "origin"
            case .caller:
                return "caller"
            case .callvalue:
                return "callvalue"
            case .calldataload:
                return "calldataload"
            case .calldatasize:
                return "calldatasize"
            case .calldatacopy:
                return "calldatacopy"
            case .codesize:
                return "codesize"
            case .codecopy:
                return "codecopy"
            case .gasprice:
                return "gasprice"
            case .extcodesize:
                return "extcodesize"
            case .extcodecopy:
                return "extcodecopy"
            case .returndatasize:
                return "returndatasize"
            case .returndatacopy:
                return "returndatacopy"
            case .extcodehash:
                return "extcodehash"
            case .blockhash:
                return "blockhash"
            case .coinbase:
                return "coinbase"
            case .timestamp:
                return "timestamp"
            case .number:
                return "number"
            case .prevrandao:
                return "prevrandao"
            case .gaslimit:
                return "gaslimit"
            case .chainid:
                return "chainid"
            case .selfbalance:
                return "selfbalance"
            case .basefee:
                return "basefee"
            case .blobhash:
                return "blobhash"
            case .blobbasefee:
                return "blobbasefee"
            case .pop:
                return "pop"
            case .mload:
                return "mload"
            case .mstore:
                return "mstore"
            case .mstore8:
                return "mstore8"
            case .sload:
                return "sload"
            case .sstore:
                return "sstore"
            case .jump:
                return "jump"
            case .jumpi:
                return "jumpi"
            case .pc:
                return "pc"
            case .msize:
                return "msize"
            case .gas:
                return "gas"
            case .jumpdest:
                return "jumpdest"
            case .tload:
                return "tload"
            case .tstore:
                return "tstore"
            case .mcopy:
                return "mcopy"
            case let .push(n, ethWord):
                return "push\(n)(\(ethWord))"
            case let .dup(n):
                return "dup\(n)"
            case let .swap(n):
                return "swap\(n)"
            case let .log(n):
                return "log\(n)"
            case .create:
                return "create"
            case .call:
                return "call"
            case .callcode:
                return "callcode"
            case .return:
                return "return"
            case .delegatecall:
                return "delegatecall"
            case .create2:
                return "create2"
            case .staticcall:
                return "staticcall"
            case .revert:
                return "revert"
            case let .invalid(hex):
                return "invalid(\(hex))"
            case .selfdestruct:
                return "selfdestruct"
            }
        }

        var size: Int {
            switch self {
            case let .push(n, _):
                n + 1
            case let .invalid(hex):
                hex.count + 1
            default:
                1
            }
        }

        var encoded: [UInt8] {
            switch self {
            case .stop:
                return [0x00]
            case .add:
                return [0x01]
            case .sub:
                return [0x03]
            case .mul:
                return [0x02]
            case .div:
                return [0x04]
            case .sdiv:
                return [0x05]
            case .mod:
                return [0x06]
            case .smod:
                return [0x07]
            case .addmod:
                return [0x08]
            case .mulmod:
                return [0x09]
            case .exp:
                return [0x0A]
            case .signextend:
                return [0x0B]
            case .lt:
                return [0x10]
            case .gt:
                return [0x11]
            case .slt:
                return [0x12]
            case .sgt:
                return [0x13]
            case .eq:
                return [0x14]
            case .iszero:
                return [0x15]
            case .and:
                return [0x16]
            case .or:
                return [0x17]
            case .xor:
                return [0x18]
            case .not:
                return [0x19]
            case .byte:
                return [0x1A]
            case .shl:
                return [0x1B]
            case .shr:
                return [0x1C]
            case .sar:
                return [0x1D]
            case .keccak256:
                return [0x20]
            case .address:
                return [0x30]
            case .balance:
                return [0x31]
            case .origin:
                return [0x32]
            case .caller:
                return [0x33]
            case .callvalue:
                return [0x34]
            case .calldataload:
                return [0x35]
            case .calldatasize:
                return [0x36]
            case .calldatacopy:
                return [0x37]
            case .codesize:
                return [0x38]
            case .codecopy:
                return [0x39]
            case .gasprice:
                return [0x3A]
            case .extcodesize:
                return [0x3B]
            case .extcodecopy:
                return [0x3C]
            case .returndatasize:
                return [0x3D]
            case .returndatacopy:
                return [0x3E]
            case .extcodehash:
                return [0x3F]
            case .blockhash:
                return [0x40]
            case .coinbase:
                return [0x41]
            case .timestamp:
                return [0x42]
            case .number:
                return [0x43]
            case .prevrandao:
                return [0x44]
            case .gaslimit:
                return [0x45]
            case .chainid:
                return [0x46]
            case .selfbalance:
                return [0x47]
            case .basefee:
                return [0x48]
            case .blobhash:
                return [0x49]
            case .blobbasefee:
                return [0x4A]
            case .pop:
                return [0x50]
            case .mload:
                return [0x51]
            case .mstore:
                return [0x52]
            case .mstore8:
                return [0x53]
            case .sload:
                return [0x54]
            case .sstore:
                return [0x55]
            case .jump:
                return [0x56]
            case .jumpi:
                return [0x57]
            case .pc:
                return [0x58]
            case .msize:
                return [0x59]
            case .gas:
                return [0x5A]
            case .jumpdest:
                return [0x5B]
            case .tload:
                return [0x5C]
            case .tstore:
                return [0x5D]
            case .mcopy:
                return [0x5E]
            case .create:
                return [0xF0]
            case .call:
                return [0xF1]
            case .callcode:
                return [0xF2]
            case .return:
                return [0xF3]
            case .delegatecall:
                return [0xF4]
            case .create2:
                return [0xF5]
            case .staticcall:
                return [0xFA]
            case .revert:
                return [0xFD]
            case let .invalid(hex):
                return [0xFE] + hex.data
            case .selfdestruct:
                return [0xFF]
            case let .push(n, value):
                let prefix = [0x5F + UInt8(n)]
                let dataBytes = Array(value.hex.data.suffix(n))
                return prefix + dataBytes
            case let .dup(n):
                return [0x80 + UInt8(n) - 1]
            case let .swap(n):
                return [0x90 + UInt8(n) - 1]
            case let .log(n):
                return [0xA0 + UInt8(n)]
            }
        }

        static func decode(_ encodedCode: Data) throws -> Operation {
            guard !encodedCode.isEmpty else {
                throw CodeError.outOfBounds
            }
            switch encodedCode[encodedCode.startIndex] {
            case 0x00:
                return .stop
            case 0x01:
                return .add
            case 0x02:
                return .mul
            case 0x03:
                return .sub
            case 0x04:
                return .div
            case 0x05:
                return .sdiv
            case 0x06:
                return .mod
            case 0x07:
                return .smod
            case 0x08:
                return .addmod
            case 0x09:
                return .mulmod
            case 0x0A:
                return .exp
            case 0x0B:
                return .signextend
            case 0x10:
                return .lt
            case 0x11:
                return .gt
            case 0x12:
                return .slt
            case 0x13:
                return .sgt
            case 0x14:
                return .eq
            case 0x15:
                return .iszero
            case 0x16:
                return .and
            case 0x17:
                return .or
            case 0x18:
                return .xor
            case 0x19:
                return .not
            case 0x1A:
                return .byte
            case 0x1B:
                return .shl
            case 0x1C:
                return .shr
            case 0x1D:
                return .sar
            case 0x20:
                return .keccak256
            case 0x30:
                return .address
            case 0x31:
                return .balance
            case 0x32:
                return .origin
            case 0x33:
                return .caller
            case 0x34:
                return .callvalue
            case 0x35:
                return .calldataload
            case 0x36:
                return .calldatasize
            case 0x37:
                return .calldatacopy
            case 0x38:
                return .codesize
            case 0x39:
                return .codecopy
            case 0x3A:
                return .gasprice
            case 0x3B:
                return .extcodesize
            case 0x3C:
                return .extcodecopy
            case 0x3D:
                return .returndatasize
            case 0x3E:
                return .returndatacopy
            case 0x3F:
                return .extcodehash
            case 0x40:
                return .blockhash
            case 0x41:
                return .coinbase
            case 0x42:
                return .timestamp
            case 0x43:
                return .number
            case 0x44:
                return .prevrandao
            case 0x45:
                return .gaslimit
            case 0x46:
                return .chainid
            case 0x47:
                return .selfbalance
            case 0x48:
                return .basefee
            case 0x49:
                return .blobhash
            case 0x4A:
                return .blobbasefee
            case 0x50:
                return .pop
            case 0x51:
                return .mload
            case 0x52:
                return .mstore
            case 0x53:
                return .mstore8
            case 0x54:
                return .sload
            case 0x55:
                return .sstore
            case 0x56:
                return .jump
            case 0x57:
                return .jumpi
            case 0x58:
                return .pc
            case 0x59:
                return .msize
            case 0x5A:
                return .gas
            case 0x5B:
                return .jumpdest
            case 0x5C:
                return .tload
            case 0x5D:
                return .tstore
            case 0x5E:
                return .mcopy
            case 0xF0:
                return .create
            case 0xF1:
                return .call
            case 0xF2:
                return .callcode
            case 0xF3:
                return .return
            case 0xF4:
                return .delegatecall
            case 0xF5:
                return .create2
            case 0xFA:
                return .staticcall
            case 0xFD:
                return .revert
            case 0xFE:
                return .invalid(Hex(encodedCode.dropFirst()))
            case 0xFF:
                return .selfdestruct
            default:
                let byte = encodedCode[encodedCode.startIndex]
                if byte >= 0x5F && byte < 0x80 {
                    let sz = Int(byte - 0x5F)
                    if sz >= encodedCode.count + 1 {
                        throw CodeError.outOfBounds
                    }
                    let data = encodedCode.dropFirst().prefix(sz)
                    return .push(sz, EthWord(hexExtending: Hex(Data(data)))!)
                } else if byte >= 0x80 && byte < 0x90 {
                    return .dup(Int(byte - 0x80) + 1)
                } else if byte >= 0x90 && byte < 0xA0 {
                    return .swap(Int(byte - 0x90) + 1)
                } else if byte >= 0xA0 && byte <= 0xA4 {
                    return .log(Int(byte - 0xA0))
                } else {
                    throw CodeError.invalidOpcode(encodedCode[0])
                }
            }
        }
    }

    /// Encodes an EVM program into opcodes.
    public static func encodeCode(_ code: Code) -> Hex {
        var res = Data()
        for operation in code {
            res += operation.encoded
        }
        return Hex(res)
    }

    /// Decodes an EVM program from Hex. Throws if the program is invalid.
    public static func decodeCode(fromHex hex: Hex) throws -> Code {
        let data = hex.data
        let dataSize = data.count
        var code: Code = []
        var index = 0
        while index < dataSize {
            let nextOperation = try Operation.decode(data[index ..< dataSize])
            code.append(nextOperation)
            index += nextOperation.size
        }
        return code
    }

    private static func getOp(_ code: Code, pc: Int) throws -> Operation {
        guard pc < code.count else {
            throw VMError.pcOutOfBounds
        }
        return code[pc]
    }

    private static func sNumberToEthWord(_ x: SNumber) throws -> EthWord {
        let xWrapped = x % maxInt256
        guard let xWord = EthWord(fromSNumber: xWrapped) else {
            throw VMError.unexpectedError("wrapped signed overflow: \(Hex.toHex(xWrapped.serialize()))")
        }
        return xWord
    }

    private static func numberToEthWord(_ x: Number) throws -> EthWord {
        let xWrapped = x % maxUint256
        guard let xWord = EthWord(fromNumber: xWrapped) else {
            throw VMError.unexpectedError("wrapped unsigned overflow: \(Hex.toHex(xWrapped.serialize()))")
        }
        return xWord
    }

    private static func wrappedUnsignedOp1(a: EthWord, _ fn: (Number) -> Number) throws -> EthWord {
        try numberToEthWord(fn(a.toNumber()))
    }

    private static func wrappedUnsignedOp2(a: EthWord, b: EthWord, _ fn: (Number, Number) -> Number) throws -> EthWord {
        try numberToEthWord(fn(a.toNumber(), b.toNumber()))
    }

    private static func wrappedUnsignedOp3(a: EthWord, b: EthWord, c: EthWord, _ fn: (Number, Number, Number) -> Number) throws -> EthWord {
        try numberToEthWord(fn(a.toNumber(), b.toNumber(), c.toNumber()))
    }

    private static func wrappedSignedOp2(a: EthWord, b: EthWord, _ fn: (SNumber, SNumber) -> SNumber) throws -> EthWord {
        // Note: the SNumber conversions here are likely wrong
        try sNumberToEthWord(fn(a.toSNumber(), b.toSNumber()))
    }

    private static func wrappedBinaryOp1(a: EthWord, _ fn: (UInt8) -> UInt8) throws -> EthWord {
        var result = Data(count: 32)
        for i in 0 ..< 32 {
            result[i] = fn(a.hex.data[i])
        }
        return EthWord(Hex(result))!
    }

    private static func wrappedBinaryOp2(a: EthWord, b: EthWord, _ fn: (UInt8, UInt8) -> UInt8) throws -> EthWord {
        var result = Data(count: 32)
        for i in 0 ..< 32 {
            result[i] = fn(a.data[i], b.data[i])
        }
        return EthWord(Hex(result))!
    }

    private static func unsignedOp1(_ context: inout Context, _ fn: (Number) -> Number) throws {
        let a = try context.pop()
        try context.push(wrappedUnsignedOp1(a: a, fn))
    }

    private static func unsignedOp2(_ context: inout Context, _ fn: (Number, Number) -> Number) throws {
        let (a, b) = try context.pop2()
        try context.push(wrappedUnsignedOp2(a: a, b: b, fn))
    }

    private static func unsignedOp3(_ context: inout Context, _ fn: (Number, Number, Number) -> Number) throws {
        let (a, b, c) = try context.pop3()
        try context.push(wrappedUnsignedOp3(a: a, b: b, c: c, fn))
    }

    private static func signedOp2(_ context: inout Context, _ fn: (SNumber, SNumber) -> SNumber) throws {
        let (a, b) = try context.pop2()
        try context.push(wrappedSignedOp2(a: a, b: b, fn))
    }

    private static func binaryOp1(_ context: inout Context, _ fn: (UInt8) -> UInt8) throws {
        let a = try context.pop()
        try context.push(wrappedBinaryOp1(a: a, fn))
    }

    private static func binaryOp2(_ context: inout Context, _ fn: (UInt8, UInt8) -> UInt8) throws {
        let (a, b) = try context.pop2()
        try context.push(wrappedBinaryOp2(a: a, b: b, fn))
    }

    private static func wordOp2(_ context: inout Context, _ fn: (EthWord, EthWord) throws -> EthWord) throws {
        let (a, b) = try context.pop2()
        try context.push(fn(a, b))
    }

    enum Op {
        static func signExtend(b: EthWord, x: EthWord) throws -> EthWord {
            guard let b_ = b.toInt(), b_ < 32, x.data[31 - b_] & 0x80 != 0 else {
                return x // Value already positive or sign-extended to this length
            }

            var res = x.data
            for i in 0 ..< 31 - b_ {
                res[i] = 0xFF
            }
            guard let value = EthWord(fromData: res) else {
                throw VMError.unexpectedError("Sign extend data too large")
            }
            return value
        }

        static func byte(i: EthWord, x: EthWord) -> EthWord {
            guard let index = i.toInt(), index < 32 else {
                return wordZero
            }
            return EthWord(fromUInt8: x.data[index])!
        }

        static func shl(shift: EthWord, value: EthWord) throws -> EthWord {
            guard let shift_ = shift.toInt(), shift_ < 256 else {
                return wordZero
            }
            return try numberToEthWord(value.toNumber() << shift_)
        }

        static func shr(shift: EthWord, value: EthWord) throws -> EthWord {
            guard let shift_ = shift.toInt(), shift_ < 256 else {
                return wordZero
            }
            return try numberToEthWord(value.toNumber() >> shift_)
        }

        static func sar(shift theShift: EthWord, value theValue: EthWord) throws -> EthWord {
            let shift = theShift.toSNumber()
            let value = theValue.toSNumber()

            if shift >= 256 {
                switch value.sign {
                case .plus:
                    return wordZero
                case .minus:
                    // Max negative shift: all bits set=
                    return EthWord(fromHexString: "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")!
                }
            }

            let shiftedValue = value >> Int(shift)
            return try! sNumberToEthWord(shiftedValue)
        }

        static func mstore(offset: EthWord, value: EthWord, context: inout Context) throws {
            guard let offset_ = offset.toInt() else {
                throw VMError.outOfMemory
            }
            try context.memoryWrite(offset: offset_, value: value.data)
        }

        static func mstore8(offset: EthWord, value: EthWord, context: inout Context) throws {
            guard let offset_ = offset.toInt() else {
                throw VMError.outOfMemory
            }
            guard !value.data.isEmpty else {
                throw VMError.unexpectedError("Empty eth word")
            }
            try context.memoryWrite(offset: offset_, value: Data([value.data.last!]))
        }

        static func mcopy(destOffset: EthWord, offset: EthWord, size: EthWord, context: inout Context) throws {
            guard let destOffset_ = destOffset.toInt(), let offset_ = offset.toInt(), let size_ = size.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try context.memoryRead(offset: offset_, bytes: size_)
            try context.memoryWrite(offset: destOffset_, value: data)
        }

        static func mload(offset: EthWord, context: inout Context) throws -> EthWord {
            guard let offset_ = offset.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try context.memoryRead(offset: offset_, bytes: 32)
            guard let value = EthWord(fromData: data) else {
                throw VMError.unexpectedError("Data read too large")
            }
            return value
        }

        static func calldataload(i: EthWord, withInput input: CallInput) throws -> EthWord {
            guard let i_ = i.toInt() else {
                return wordZero
            }
            let data = input.readData(offset: i_, bytes: 32)
            guard let value = EthWord(fromData: data) else {
                throw VMError.unexpectedError("Call data read too large")
            }
            return value
        }

        private static func performRead(offset: EthWord, size: EthWord, readFn fn: (Int, Int) throws -> Data) throws -> Data {
            guard let size_ = size.toInt() else {
                throw VMError.outOfMemory
            }
            if let offset_ = offset.toInt() {
                return try fn(offset_, size_)
            } else {
                return Data(repeating: 0, count: size_)
            }
        }

        static func calldatacopy(destOffset: EthWord, offset: EthWord, size: EthWord, withInput input: CallInput, context: inout Context) throws {
            guard let destOffset_ = destOffset.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try performRead(offset: offset, size: size) { offset, bytes in
                input.readData(offset: offset, bytes: bytes)
            }
            try context.memoryWrite(offset: destOffset_, value: data)
        }

        static func codecopy(destOffset: EthWord, offset: EthWord, size: EthWord, context: inout Context) throws {
            guard let destOffset_ = destOffset.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try performRead(offset: offset, size: size) { offset, bytes in
                readZeroPaddedData(offset: offset, bytes: bytes, fromData: context.codeEncoded.data)
            }
            try context.memoryWrite(offset: destOffset_, value: data)
        }

        static func returnDataCopy(destOffset: EthWord, offset: EthWord, size: EthWord, context: inout Context) throws {
            guard let destOffset_ = destOffset.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try performRead(offset: offset, size: size) { offset, bytes in
                readZeroPaddedData(offset: offset, bytes: bytes, fromData: context.returnData)
            }
            try context.memoryWrite(offset: destOffset_, value: data)
        }

        static func jump(counter: EthWord, context: inout Context) throws {
            guard let counter_ = counter.toInt() else {
                throw VMError.invalidJumpDest
            }
            context.pc = counter_
            guard let operation = context.getOperation(), operation == .jumpdest else {
                throw VMError.invalidJumpDest
            }
        }

        static func jumpi(counter: EthWord, b: EthWord, context: inout Context) throws -> Bool {
            if b != wordZero {
                try jump(counter: counter, context: &context)
                return false
            } else {
                return true
            }
        }

        static func pc(context: inout Context) throws {
            guard let pc = EthWord(fromInt: context.pc) else {
                throw VMError.unexpectedError("Invalid pc")
            }
            try context.push(pc)
        }

        static func msize(context: inout Context) throws {
            guard let memorySize = EthWord(fromInt: context.memory.count) else {
                throw VMError.unexpectedError("Invalid memory size")
            }
            try context.push(memorySize)
        }

        static func `return`(offset: EthWord, size: EthWord, context: inout Context) throws {
            guard let offset_ = offset.toInt(), let size_ = size.toInt() else {
                throw VMError.outOfMemory
            }
            context.returnData = try context.memoryRead(offset: offset_, bytes: size_)
            context.halted = true
        }

        static func revert(offset: EthWord, size: EthWord, context: inout Context) throws {
            context.reverted = true
            try `return`(offset: offset, size: size, context: &context)
        }

        static func keccak256(offset: EthWord, size: EthWord, context: inout Context) throws -> EthWord {
            guard let offset_ = offset.toInt(), let size_ = size.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try context.memoryRead(offset: offset_, bytes: size_)
            let hash = SwiftKeccak.keccak256(data)
            guard let hashWord = EthWord(fromData: hash) else {
                throw VMError.unexpectedError("hash does not fit in word")
            }
            return hashWord
        }

        static func staticCall(context: inout Context) throws {
            _ = try context.pop() // gas
            let addressWord = try context.pop()
            let argsOffset_ = try context.pop()
            let argsSize_ = try context.pop()
            let retOffset_ = try context.pop()
            let retSize_ = try context.pop()

            guard let address = EthAddress(fromData: addressWord.data.subdata(in: 12 ..< 32)) else {
                throw VMError.unexpectedError("Invalid eth address: \(addressWord.description)")
            }

            guard
                let argsOffset = argsOffset_.toInt(),
                let argsSize = argsSize_.toInt(),
                let retOffset = retOffset_.toInt(),
                let retSize = retSize_.toInt()
            else {
                throw VMError.outOfMemory
            }
            let args = try context.memoryRead(offset: argsOffset, bytes: argsSize)

            guard let ffi = context.ffis[address] else {
                throw VMError.noSuchFFI(address)
            }

            switch ffi(Hex(args)) {
            case let .ok(resultData):
                var returnDataToCopy: Data

                if resultData.count >= retSize {
                    // Take the first `retSize` bytes
                    returnDataToCopy = Data(resultData.data.prefix(retSize))
                } else {
                    // Pad the data with zeros on the right
                    var paddedData: Data = resultData.data
                    let zerosNeeded = retSize - paddedData.count
                    let zeros = Data(repeating: 0x00, count: zerosNeeded)
                    paddedData.append(zeros)
                    returnDataToCopy = paddedData
                }

                try context.memoryWrite(offset: retOffset, value: returnDataToCopy)
                context.returnData = resultData.data
                try context.push(wordOne)

            case let .revert(revertData):
                context.halted = true
                context.reverted = true
                context.returnData = revertData.data
                try context.push(wordZero)
            }
        }
    }

    private static func runSingleOp(withInput input: CallInput, withContext context: inout Context) throws {
        var showContextDescription = true
        var shouldIncrementPC = true
        guard let operation = context.getOperation() else {
            throw VMError.pcOutOfBounds
        }
        switch operation {
        case .stop:
            context.halted = true
        case .add:
            try unsignedOp2(&context) { $0 + $1 }
        case .sub:
            try unsignedOp2(&context) { $1 > $0 ? maxUint256 - $1 + $0 : $0 - $1 }
        case .mul:
            try unsignedOp2(&context) { $0 * $1 }
        case .div:
            try unsignedOp2(&context) { $1 == .zero ? .zero : $0 / $1 }
        case .sdiv:
            try signedOp2(&context) { $1 == .zero ? .zero : $0 / $1 }
        case .mod:
            try unsignedOp2(&context) { $1 == .zero ? .zero : $0 % $1 }
        case .smod:
            try signedOp2(&context) { $1 == .zero ? .zero : $0 % $1 }
        case .addmod:
            try unsignedOp3(&context) { $2 == .zero ? .zero : (($0 + $1) % $2) }
        case .mulmod:
            try unsignedOp3(&context) { $2 == .zero ? .zero : (($0 * $1) % $2) }
        case .exp:
            try unsignedOp2(&context) { $0.power($1, modulus: maxUint256) }
        case .signextend:
            let (b, x) = try context.pop2()
            try context.push(Op.signExtend(b: b, x: x))
        case .lt:
            try unsignedOp2(&context) { $0 < $1 ? one : .zero }
        case .gt:
            try unsignedOp2(&context) { $0 > $1 ? one : .zero }
        case .slt:
            try signedOp2(&context) { $0 < $1 ? sOne : sZero }
        case .sgt:
            try signedOp2(&context) { $0 > $1 ? sOne : sZero }
        case .eq:
            try unsignedOp2(&context) { $0 == $1 ? one : .zero }
        case .iszero:
            try unsignedOp1(&context) { $0 == .zero ? one : .zero }
        case .and:
            try binaryOp2(&context) { $0 & $1 }
        case .or:
            try binaryOp2(&context) { $0 | $1 }
        case .xor:
            try binaryOp2(&context) { $0 ^ $1 }
        case .not:
            try binaryOp1(&context) { $0 ^ 255 }
        case .byte:
            try wordOp2(&context, Op.byte)
        case .shl:
            try wordOp2(&context, Op.shl)
        case .shr:
            try wordOp2(&context, Op.shr)
        case .sar:
            try wordOp2(&context, Op.sar)
        case .keccak256:
            let (offset, size) = try context.pop2()
            try context.push(Op.keccak256(offset: offset, size: size, context: &context))
        case .callvalue:
            try context.push(numberToEthWord(input.value))
        case .calldataload:
            let i = try context.pop()
            try context.push(Op.calldataload(i: i, withInput: input))
        case .calldatasize:
            guard let calldataSize = EthWord(fromInt: input.calldata.count) else {
                throw VMError.unexpectedError("Invalid calldata size")
            }
            try context.push(calldataSize)
        case .calldatacopy:
            let (destOffset, offset, size) = try context.pop3()
            try Op.calldatacopy(destOffset: destOffset, offset: offset, size: size, withInput: input, context: &context)
        case .codesize:
            guard let codeSize = EthWord(fromInt: context.codeEncoded.count) else {
                throw VMError.unexpectedError("Invalid code size")
            }
            try context.push(codeSize)
        case .codecopy:
            let (destOffset, offset, size) = try context.pop3()
            try Op.codecopy(destOffset: destOffset, offset: offset, size: size, context: &context)
        case .pop:
            _ = try context.pop()
        case .mload:
            let offset = try context.pop()
            try context.push(Op.mload(offset: offset, context: &context))
        case .mstore:
            let (offset, value) = try context.pop2()
            try Op.mstore(offset: offset, value: value, context: &context)
        case .mstore8:
            let (offset, value) = try context.pop2()
            try Op.mstore8(offset: offset, value: value, context: &context)
        case .mcopy:
            let (destOffset, offset, size) = try context.pop3()
            try Op.mcopy(destOffset: destOffset, offset: offset, size: size, context: &context)
        case .jump:
            showContextDescription = false
            debugShowContext(context)
            shouldIncrementPC = false
            try Op.jump(counter: context.pop(), context: &context)
        case .jumpi:
            showContextDescription = false
            debugShowContext(context)
            let (counter, b) = try context.pop2()
            shouldIncrementPC = try Op.jumpi(counter: counter, b: b, context: &context)
        case .pc:
            try Op.pc(context: &context)
        case .msize:
            try Op.msize(context: &context)
        case .gas:
            try context.push(gasAmount)
        case .jumpdest:
            break
        case .tstore:
            let (key, value) = try context.pop2()
            context.tStorage[key] = value
        case .tload:
            let key = try context.pop()
            let value = context.tStorage[key] ?? EthWord(fromInt: 0)!
            try context.push(value)
        case let .push(_, v):
            try context.push(v)
        case let .dup(n):
            try context.push(context.peek(n - 1))
        case let .swap(n):
            try context.swap(0, n)
        case .return:
            let (offset, size) = try context.pop2()
            try Op.return(offset: offset, size: size, context: &context)
        case .revert:
            let (offset, size) = try context.pop2()
            try Op.revert(offset: offset, size: size, context: &context)
        case .invalid:
            throw VMError.invalidOperation
        case .staticcall:
            try Op.staticCall(context: &context)
        case .returndatasize:
            guard let codeSize = EthWord(fromInt: context.returnData.count) else {
                throw VMError.unexpectedError("Invalid return data size")
            }
            try context.push(codeSize)
        case .returndatacopy:
            let (destOffset, offset, size) = try context.pop3()
            try Op.returnDataCopy(destOffset: destOffset, offset: offset, size: size, context: &context)
        case .address, .balance, .origin, .caller, .gasprice, .extcodesize, .extcodecopy, .extcodehash, .blockhash, .coinbase, .timestamp, .number, .prevrandao, .gaslimit, .chainid, .selfbalance, .basefee, .blobhash, .blobbasefee, .sload, .sstore, .log, .create, .call, .callcode, .delegatecall, .create2, .selfdestruct:
            throw VMError.impure(operation)
        }
        if showContextDescription {
            debugShowContext(context)
        }

        if shouldIncrementPC {
            context.incrementPC(operation: operation)
        }
    }

    private static func debugShowContext(_ context: Context) {
        #if DEBUG_EVM
            print(context.description)
        #endif
    }

    /// Executes the Ethereum Virtual Machine (EVM) with the given `code` and `input`.
    /// - Parameters:
    ///   - code: The bytecode to be executed.
    ///   - input: The input data for the execution.
    ///   - ffis: A dictionary of addresses to FFI (natively implemented) functions available to the VM.
    /// - Returns: The result of the execution.
    public static func execVm(code: Code, withInput input: CallInput, withFunctions ffis: FFIMap = [:]) throws -> ExecutionResult {
        let mergedFFIs = defaultFFIs.merging(ffis) { _, new in new }
        var context = Context(withCode: code, withFunctions: mergedFFIs)
        while !context.halted {
            try runSingleOp(withInput: input, withContext: &context)
        }
        return ExecutionResult(
            stack: context.stack,
            reverted: context.reverted,
            returnData: Hex(context.returnData)
        )
    }

    /**
      An enumeration of errors that can occur during `runQuery`, such as a `revert`.

      - invalidCode(CodeError): Raise when the bytecode passed in fails decoding
      - vmError(VMError): Raised when a VM exception occurs (e.g. VMError.stackUnderflow)
      - error(ABI.Function, ABI.Value): A wrapped error from a revert that matched an error signature passed in the `withErrors` parameter
      - revert(Hex): For a revert that does not match any known error types.
     */
    public enum QueryError: Error, Equatable {
        case invalidCode(CodeError)
        case vmError(VMError)
        case error(ABI.Function, ABI.Value)
        case revert(Hex)
    }

    /// Executes the Ethereum Virtual Machine (EVM) with the given `code` and `input`, returning the `RETURN` result. Throws on `REVERT` or other VM error.
    /// - Parameters:
    ///   - bytecode: The bytecode to be executed.
    ///   - query: The ABI-encoded function call to execute.
    ///   - errors: A dictionary of known errors which we will attempt to decode from during a revert and throw a `QueryError.error`
    ///   - ffis: A dictionary of addresses to FFI (natively implemented) functions available to the VM.
    /// - Returns: The hex result of the execution of program successfully `RETURN`ed.
    public static func runQuery(bytecode: Hex, query: Hex, withValue value: Number = Number(0), withErrors errors: [ABI.Function] = [], withFunctions ffis: FFIMap = [:]) throws -> Hex {
        let code: Code
        do {
            code = try EVM.decodeCode(fromHex: bytecode)
        } catch let error as CodeError {
            throw QueryError.invalidCode(error)
        } catch {
            throw error
        }
        let input = CallInput(calldata: query, value: value)
        let executionResult: ExecutionResult
        do {
            executionResult = try EVM.execVm(code: code, withInput: input, withFunctions: ffis)
        } catch let error as VMError {
            throw QueryError.vmError(error)
        } catch {
            throw error
        }
        if executionResult.reverted {
            let errorDict = Dictionary(errors.map { ($0.signatureHash, $0) }, uniquingKeysWith: { first, _ in first })
            if executionResult.returnData.count >= 4, let error = errorDict[Hex(executionResult.returnData.data.subdata(in: 0 ..< 4))] {
                // Note: this decoding shouldn't fail if the contract is from proper Solidity, but it's always possible,
                //       and so we'll default to a standard revert in such a case.
                if let value = try? error.decodeInput(input: executionResult.returnData) {
                    throw QueryError.error(error, value)
                }
            }

            throw QueryError.revert(executionResult.returnData)
        }
        return executionResult.returnData
    }
}

extension EVM.VMError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .stackUnderflow:
            return NSLocalizedString("Stack underflow occurred.", comment: "Stack Underflow Error")
        case .stackOverflow:
            return NSLocalizedString("Stack overflow occurred.", comment: "Stack Overflow Error")
        case .pcOutOfBounds:
            return NSLocalizedString("Program counter went out of bounds.", comment: "PC Out of Bounds Error")
        case .invalidJumpDest:
            return NSLocalizedString("Invalid jump destination.", comment: "Invalid Jump Dest")
        case .outOfMemory:
            return NSLocalizedString("Memory read or write out of bounds.", comment: "Out-of-Memory Error")
        case .invalidOperation:
            return NSLocalizedString("Invalid operation `INVALID` was executed.", comment: "Invalid Operation")
        case let .impure(operation):
            return NSLocalizedString("Failed to execute impure operation \(operation.description)", comment: "Impure Operation")
        case let .notImplemented(operation):
            return NSLocalizedString("Unimplemented operation \(operation.description)", comment: "Not Implemented Operation")
        case let .noSuchFFI(address):
            return NSLocalizedString("No such FFI at \(address.description)", comment: "No such FFI")
        case let .unexpectedError(message):
            return String(format: NSLocalizedString("An unexpected error occurred: %@", comment: "Unexpected Error"), message)
        }
    }
}
