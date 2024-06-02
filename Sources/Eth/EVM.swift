import BigInt
import Foundation

enum EVM {
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

        mutating func pop2() throws -> (EthWord, EthWord) {
            guard stack.count >= 2 else {
                throw VMError.stackUnderflow
            }
            let a: EthWord = stack.removeFirst()
            let b: EthWord = stack.removeFirst()
            return (a, b)
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
        case add
        case stop
        case push(EthWord)
    }

    private static func getOp(_ code: Code, pc: Int) throws -> Operation {
        // TODO: Probably need the opMap thing
        guard pc < code.count else {
            throw VMError.pcOutOfBounds
        }
        return code[pc]
    }

    private static func wrappedUnsignedOp(a: EthWord, b: EthWord, _ fn: (BigUInt, BigUInt) -> BigUInt) throws -> EthWord {
        let res = fn(a.toBigUInt(), b.toBigUInt())
        let resWrapped = res % (BigUInt(1) << 256)
        guard let resWord = EthWord(fromBigUInt: resWrapped) else {
            throw VMError.unexpectedError("wrapped unsigned overflow")
        }
        return resWord
    }

    private static func runSingleOp(code: Code, withInput _: CallInput, withContext context: inout Context) throws {
        switch try getOp(code, pc: context.pc) {
        case .add:
            let (a, b) = try context.pop2()
            try context.push(wrappedUnsignedOp(a: a, b: b) { $0 + $1 })
            context.incrementPC()
        case let .push(v):
            try context.push(v)
            context.incrementPC()
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
