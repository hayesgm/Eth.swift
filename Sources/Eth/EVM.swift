import BigInt
import Foundation

enum EVM {
    static let maxUint256 = BigUInt(1) << 256
    static let maxInt256 = BigInt(1) << 256
    static let one = BigUInt(1)
    static let sZero = BigInt(0)
    static let sOne = BigInt(1)
    static let wordZero = EthWord(fromBigInt: .zero)!

    enum VMError: Error, Equatable {
        case stackUnderflow
        case stackOverflow
        case pcOutOfBounds
        case invalidJumpDest
        case outOfMemory
        case invalidOperation
        case impure(Operation)
        case notImplemented(Operation)
        case unexpectedError(String)
    }

    struct CallInput {
        let data: Data
        let value: BigUInt

        func readData(offset: Int, bytes sz: Int) throws -> Data {
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
    }

    typealias Code = [Operation]
    typealias Stack = [EthWord]

    struct Context {
        var pc: Int = 0
        var stack: Stack = []
        var memory: Data = .init()
        var halted: Bool = false
        var reverted: Bool = false
        var returnData: Data = .init()
        var tStorage: [EthWord: EthWord] = [:]
        let code: Code
        var opMap: [Int: Operation]

        init(withCode code: Code) {
            self.code = code
            opMap = Context.buildOpMap(code: code)
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

    struct ExecutionResult: Equatable {
        let stack: Stack
        let reverted: Bool
        let returnData: Data
    }

    enum Operation: Equatable {
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
        case invalid
        case selfdestruct

        var description: String {
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
            case .invalid:
                return "invalid"
            case .selfdestruct:
                return "selfdestruct"
            }
        }

        var size: Int {
            switch self {
            case let .push(n, _):
                n + 1
            default:
                1
            }
        }
    }

    private static func getOp(_ code: Code, pc: Int) throws -> Operation {
        guard pc < code.count else {
            throw VMError.pcOutOfBounds
        }
        return code[pc]
    }

    private static func bigIntToEthWord(_ x: BigInt) throws -> EthWord {
        let xWrapped = x % maxInt256
        guard let xWord = EthWord(fromBigInt: xWrapped) else {
            throw VMError.unexpectedError("wrapped signed overflow: \(Hex.toHex(xWrapped.serialize()))")
        }
        return xWord
    }

    private static func bigUIntToEthWord(_ x: BigUInt) throws -> EthWord {
        let xWrapped = x % maxUint256
        guard let xWord = EthWord(fromBigUInt: xWrapped) else {
            throw VMError.unexpectedError("wrapped unsigned overflow: \(Hex.toHex(xWrapped.serialize()))")
        }
        return xWord
    }

    private static func wrappedUnsignedOp1(a: EthWord, _ fn: (BigUInt) -> BigUInt) throws -> EthWord {
        try bigUIntToEthWord(fn(a.toBigUInt()))
    }

    private static func wrappedUnsignedOp2(a: EthWord, b: EthWord, _ fn: (BigUInt, BigUInt) -> BigUInt) throws -> EthWord {
        try bigUIntToEthWord(fn(a.toBigUInt(), b.toBigUInt()))
    }

    private static func wrappedUnsignedOp3(a: EthWord, b: EthWord, c: EthWord, _ fn: (BigUInt, BigUInt, BigUInt) -> BigUInt) throws -> EthWord {
        try bigUIntToEthWord(fn(a.toBigUInt(), b.toBigUInt(), c.toBigUInt()))
    }

    private static func wrappedSignedOp2(a: EthWord, b: EthWord, _ fn: (BigInt, BigInt) -> BigInt) throws -> EthWord {
        // Note: the BigInt conversions here are likely wrong
        try bigIntToEthWord(fn(a.toBigInt(), b.toBigInt()))
    }

    private static func wrappedBinaryOp1(a: EthWord, _ fn: (UInt8) -> UInt8) throws -> EthWord {
        var result = Data(count: 32)
        for i in 0 ..< 32 {
            result[i] = fn(a.data[i])
        }
        return EthWord(result)!
    }

    private static func wrappedBinaryOp2(a: EthWord, b: EthWord, _ fn: (UInt8, UInt8) -> UInt8) throws -> EthWord {
        var result = Data(count: 32)
        for i in 0 ..< 32 {
            result[i] = fn(a.data[i], b.data[i])
        }
        return EthWord(result)!
    }

    private static func unsignedOp1(_ context: inout Context, _ fn: (BigUInt) -> BigUInt) throws {
        let a = try context.pop()
        try context.push(wrappedUnsignedOp1(a: a, fn))
    }

    private static func unsignedOp2(_ context: inout Context, _ fn: (BigUInt, BigUInt) -> BigUInt) throws {
        let (a, b) = try context.pop2()
        try context.push(wrappedUnsignedOp2(a: a, b: b, fn))
    }

    private static func unsignedOp3(_ context: inout Context, _ fn: (BigUInt, BigUInt, BigUInt) -> BigUInt) throws {
        let (a, b, c) = try context.pop3()
        try context.push(wrappedUnsignedOp3(a: a, b: b, c: c, fn))
    }

    private static func signedOp2(_ context: inout Context, _ fn: (BigInt, BigInt) -> BigInt) throws {
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
            return try bigUIntToEthWord(value.toBigUInt() << shift_)
        }

        static func shr(shift: EthWord, value: EthWord) throws -> EthWord {
            guard let shift_ = shift.toInt(), shift_ < 256 else {
                return wordZero
            }
            return try bigUIntToEthWord(value.toBigUInt() >> shift_)
        }

        static func sar(shift: EthWord, value: EthWord) throws -> EthWord {
            // TODO: Something is a little off here
            guard let shift_ = shift.toInt(), shift_ < 256 else {
                return wordZero
            }
            let signBitSet = (value.data[0] & 0x80) != 0
            let shiftedValue: BigUInt
            if signBitSet {
                // Calculate the mask for sign extension
                let bitsToShift = 255 - shift_
                let signExtensionMask = (BigUInt(1) << bitsToShift) - 1
                let signExtension = signExtensionMask << bitsToShift
                // throw VMError.unexpectedError("shift=\(shift_), signExtensionMask=\(EthWord(fromBigUInt: signExtensionMask)), signExtension=\(EthWord(fromBigUInt: signExtension))")
                // Perform the shift and apply the sign extension
                shiftedValue = (value.toBigUInt() >> shift_) | signExtension
            } else {
                // Perform a normal right shift for non-negative values
                shiftedValue = value.toBigUInt() >> shift_
            }

            return try bigUIntToEthWord(shiftedValue)
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

        static func mload(offset: EthWord, context: inout Context) throws -> EthWord {
            guard let offset_ = offset.toInt() else {
                throw VMError.outOfMemory
            }
            let data = try context.memoryRead(offset: offset_, bytes: 32)
            guard let value = EthWord(data) else {
                throw VMError.unexpectedError("Data read too large")
            }
            return value
        }

        static func calldataload(i: EthWord, withInput input: CallInput) throws -> EthWord {
            guard let i_ = i.toInt() else {
                return wordZero
            }
            let data = try input.readData(offset: i_, bytes: 32)
            guard let value = EthWord(data) else {
                throw VMError.unexpectedError("Call data read too large")
            }
            return value
        }

        static func calldatacopy(destOffset: EthWord, offset: EthWord, size: EthWord, withInput input: CallInput, context: inout Context) throws {
            guard let destOffset_ = destOffset.toInt(), let size_ = size.toInt() else {
                throw VMError.outOfMemory
            }
            let data: Data
            if let offset_ = offset.toInt() {
                data = try input.readData(offset: offset_, bytes: size_)
            } else {
                data = Data(repeating: 0, count: size_)
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

        static func jumpi(counter: EthWord, b: EthWord, context: inout Context) throws {
            if b != wordZero {
                try jump(counter: counter, context: &context)
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
    }

    private static func runSingleOp(withInput input: CallInput, withContext context: inout Context) throws {
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
            // TODO: Sign Extend
            break
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
        case .callvalue:
            try context.push(bigUIntToEthWord(input.value))
        case .calldataload:
            let i = try context.pop()
            try context.push(Op.calldataload(i: i, withInput: input))
        case .calldatasize:
            guard let calldataSize = EthWord(fromInt: input.data.count) else {
                throw VMError.unexpectedError("Invalid calldata size")
            }
            try context.push(calldataSize)
        case .calldatacopy:
            let (destOffset, offset, size) = try context.pop3()
            try Op.calldatacopy(destOffset: destOffset, offset: offset, size: size, withInput: input, context: &context)
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
        case .jump:
            try Op.jump(counter: context.pop(), context: &context)
        case .jumpi:
            let (counter, b) = try context.pop2()
            try Op.jumpi(counter: counter, b: b, context: &context)
        case .pc:
            try Op.pc(context: &context)
        case .msize:
            try Op.msize(context: &context)
        case .jumpdest:
            break
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
        case .address, .balance, .origin, .caller, .gasprice, .extcodesize, .extcodecopy, .returndatasize, .returndatacopy, .extcodehash, .blockhash, .coinbase, .timestamp, .number, .prevrandao, .gaslimit, .chainid, .selfbalance, .basefee, .blobhash, .blobbasefee, .sload, .sstore, .gas, .log, .create, .call, .callcode, .delegatecall, .create2, .staticcall, .selfdestruct:
            throw VMError.impure(operation)
        case .keccak256, .codesize, .codecopy, .tload, .tstore, .mcopy:
            throw VMError.notImplemented(operation)
        }
        context.incrementPC(operation: operation)
    }

    static func execVm(code: Code, withInput inputs: CallInput) throws -> ExecutionResult {
        var context = Context(withCode: code)
        // throw VMError.unexpectedError("\(context.opMap)")
        while !context.halted {
            try runSingleOp(withInput: inputs, withContext: &context)
        }
        return ExecutionResult(
            stack: context.stack,
            reverted: context.reverted,
            returnData: context.returnData
        )
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
            return NSLocalizedString("Invalid operation (INVALID) was executed.", comment: "Invalid Operation")
        case let .impure(operation):
            return NSLocalizedString("Failed to execute impure operation \(operation.description)", comment: "Impure Operation")
        case let .notImplemented(operation):
            return NSLocalizedString("Unimplemented operation \(operation.description)", comment: "Not Implemented Operation")
        case let .unexpectedError(message):
            return String(format: NSLocalizedString("An unexpected error occurred: %@", comment: "Unexpected Error"), message)
        }
    }
}
