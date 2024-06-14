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

        enum ABIEntry: Decodable {
            case function(Function)
            case error(Error)

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
                default:
                    throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown ABI entry type")
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
