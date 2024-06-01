import BigInt
import Foundation

enum EVM {
    enum VMError: Error {
        case stackUnderflow
        case stackOverflow
        case pcOutOfBounds
    }

    struct CallInput {
        let data: Data
        let value: BigInt
    }

    typealias Stack = [EthWord]

    struct Context {
        var pc: Int = 0
        var stack: Stack = []
        var memory: Data = .init()
        var halted: Bool = false
        var returnData: Data = .init()
        var tStorage: [HexWord: HexWord] = [:]

        func pop2() throws -> (EthWord, EthWord) {
            guard stack.count >= 2 else {
                throw VMError.stackUnderflow
            }
            let [a, b] = stack.removeFirst(2)
            return (a!, b!)
        }

        func push(x: EthWord) throws {
            guard if stack.count < 1024 else {
                throw VMError.stackOverflow
            }
            stack.insert(x, at: 0)
        }

        func incrementPC() {
            pc++
        }
    }

    struct ExecutionResult {
        let stack: Stack
        let returnData: Data
    }

    enum Operation {
        case add
        case push(EthWord)
    }

    typealias Code = [Operation]
    typealias Stack = [EthWord]

    private static func getOp(_ code: code, pc: pc) throws -> Operation {
        // TODO: Probably need the opMap thing
        guard pc < code.count else {
            throw VMError.pcOutOfBounds
        }
        return code[pc]
    }

    private static func runSingleOp(code: Code, withInputs _: CallInput, withContext _: inout Context) throws {
        switch getOp(code, pc: context.pc) {
        case .add:
            let (a, b) = try context.pop2()
            try context.push(a + b)
            context.incrementPC()
        case let .push(v):
            try context.push(v)
            context.incrementPC()
        }
    }

    static func execVm(code: Code, withInputs inputs: CallInput) throws -> ExecutionResult {
        var context = Context()
        while !context.halted {
            try runSingleOp(code: code, withInputs: inputs, withContext: context)
        }
        return ExecutionResult(
            stack: context.stack,
            returnData: context.returnData
        )
    }
}
