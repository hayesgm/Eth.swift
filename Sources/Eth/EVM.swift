import BigInt
import Foundation

enum EVM {
    static let maxUint256 = BigUInt(1) << 256
    static let maxInt256 = BigInt(1) << 256
    static let one = BigUInt(1)
    static let sZero = BigInt(0)
    static let sOne = BigInt(1)
    static let wordZero = EthWord(fromBigInt: .zero)!

    enum VMError: Error {
        case stackUnderflow
        case stackOverflow
        case pcOutOfBounds
        case unexpectedError(String)
    }

    struct CallInput {
        let data: Data
        let value: BigInt
    }

    typealias Code = [Operation]
    typealias Stack = [EthWord]

    struct Context {
        var pc: Int = 0
        var stack: Stack = []
        var memory: Data = .init()
        var halted: Bool = false
        var returnData: Data = .init()
        var tStorage: [EthWord: EthWord] = [:]

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

        mutating func push(_ x: EthWord) throws {
            guard stack.count < 1024 else {
                throw VMError.stackOverflow
            }
            stack.insert(x, at: 0)
        }

        mutating func incrementPC() {
            pc = pc + 1
        }
    }

    struct ExecutionResult: Equatable {
        let stack: Stack
        let returnData: Data
    }

    enum Operation {
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
        case push(EthWord)
    }

    private static func getOp(_ code: Code, pc: Int) throws -> Operation {
        // TODO: Probably need the opMap thing
        guard pc < code.count else {
            throw VMError.pcOutOfBounds
        }
        return code[pc]
    }

    private static func wrappedUnsignedOp1(a: EthWord, _ fn: (BigUInt) -> BigUInt) throws -> EthWord {
        let res = fn(a.toBigUInt())
        let resWrapped = res % maxUint256
        guard let resWord = EthWord(fromBigUInt: resWrapped) else {
            throw VMError.unexpectedError("wrapped unsigned overflow: \(Hex.toHex(resWrapped.serialize()))")
        }
        return resWord
    }

    private static func wrappedUnsignedOp2(a: EthWord, b: EthWord, _ fn: (BigUInt, BigUInt) -> BigUInt) throws -> EthWord {
        let res = fn(a.toBigUInt(), b.toBigUInt())
        let resWrapped = res % maxUint256
        guard let resWord = EthWord(fromBigUInt: resWrapped) else {
            throw VMError.unexpectedError("wrapped unsigned overflow: \(Hex.toHex(resWrapped.serialize()))")
        }
        return resWord
    }

    private static func wrappedUnsignedOp3(a: EthWord, b: EthWord, c: EthWord, _ fn: (BigUInt, BigUInt, BigUInt) -> BigUInt) throws -> EthWord {
        let res = fn(a.toBigUInt(), b.toBigUInt(), c.toBigUInt())
        let resWrapped = res % maxUint256
        guard let resWord = EthWord(fromBigUInt: resWrapped) else {
            throw VMError.unexpectedError("wrapped unsigned overflow: \(Hex.toHex(resWrapped.serialize()))")
        }
        return resWord
    }

    private static func wrappedSignedOp2(a: EthWord, b: EthWord, _ fn: (BigInt, BigInt) -> BigInt) throws -> EthWord {
        // Note: the BigInt conversions here are likely wrong
        let res = fn(a.toBigInt(), b.toBigInt())
        let resWrapped = res % maxInt256
        guard let resWord = EthWord(fromBigInt: resWrapped) else {
            throw VMError.unexpectedError("wrapped signed overflow: \(Hex.toHex(resWrapped.serialize()))")
        }
        return resWord
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
            // TODO: This could be faster..
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

    private static func wordOp2(_ context: inout Context, _ fn: (EthWord, EthWord) -> EthWord) throws {
        let (a, b) = try context.pop2()
        try context.push(fn(a, b))
    }

    private static func byte(i: EthWord, x: EthWord) -> EthWord {
        // TODO: Why am I making this so hard?
        return x
        guard let index = i.toInt(), index >= 0, index < 32 else {
            return wordZero
        }
        let intValue = if index == 0 {
            x.data[0]
        } else {
            x.data.dropFirst(index)[0]
        }
        return EthWord(fromUInt8: intValue)!
    }

    private static func runSingleOp(code: Code, withInput _: CallInput, withContext context: inout Context) throws {
        let operation = try getOp(code, pc: context.pc)
        // TODO: If not jump
        context.incrementPC()
        switch operation {
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
            try wordOp2(&context, byte)
        case let .push(v):
            try context.push(v)
        case .stop:
            context.halted = true
        }
    }

    static func execVm(code: Code, withInput inputs: CallInput) throws -> ExecutionResult {
        var context = Context()
        while !context.halted {
            try runSingleOp(code: code, withInput: inputs, withContext: &context)
        }
        return ExecutionResult(
            stack: context.stack,
            returnData: context.returnData
        )
    }
}
