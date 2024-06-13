import Foundation

struct Contract: Decodable {
    struct ABI: Decodable {
        struct Function: Decodable {
            struct Parameter: Decodable {
                let name: String
                let type: String
                let internalType: String
                let components: [Parameter]?
            }

            let type: String
            let name: String
            let inputs: [Parameter]
            let outputs: [Parameter]
            let stateMutability: String
        }

        struct Error: Decodable {
            let type: String
            let name: String
            let inputs: [Function.Parameter]
        }

        struct Constructor: Decodable {
            let inputs: [Function.Parameter]?
            let stateMutability: String
        }

        struct Fallback: Decodable {
            let stateMutability: String
        }

        struct Receive: Decodable {
            let stateMutability: String
        }

        struct Event: Decodable {
            let name: String
            let inputs: [Function.Parameter]
        }

        enum ABIEntry: Decodable {
            case function(Function)
            case error(Error)
            case constructor(Constructor)
            case fallback(Fallback)
            case receive(Receive)
            case event(Event)

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(String.self, forKey: .type)

                switch type {
                case "function":
                    let function = try Function(from: decoder)
                    self = .function(function)
                case "error":
                    let error = try Error(from: decoder)
                    self = .error(error)
                case "constructor":
                    let constructor = try Constructor(from: decoder)
                    self = .constructor(constructor)
                case "fallback":
                    let fallback = try Fallback(from: decoder)
                    self = .fallback(fallback)
                case "receive":
                    let receive = try Receive(from: decoder)
                    self = .receive(receive)
                case "event":
                    let receive = try Event(from: decoder)
                    self = .event(receive)
                default:
                    throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown ABI entry type: \(type)")
                }
            }

            private enum CodingKeys: String, CodingKey {
                case type
            }
        }

        let abi: [ABIEntry]
    }

    struct Bytecode: Decodable {
        let object: String
    }

    struct DeployedBytecode: Decodable {
        let object: String
    }

    let abi: [ABI.ABIEntry]
    let bytecode: Bytecode
    let deployedBytecode: DeployedBytecode

    var functions: [ABI.Function] {
        return abi.compactMap {
            if case let .function(function) = $0 {
                return function
            }
            return nil
        }
    }

    var errors: [ABI.Error] {
        return abi.compactMap {
            if case let .error(error) = $0 {
                return error
            }
            return nil
        }
    }
}

// Function to decode JSON data
func decodeContract(from jsonData: Data) -> Contract {
    let decoder = JSONDecoder()
    let contract = try! decoder.decode(Contract.self, from: jsonData)
    return contract
}
