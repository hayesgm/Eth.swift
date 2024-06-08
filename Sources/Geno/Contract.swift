import Foundation

struct Contract: Decodable {
    struct ABI: Decodable {
        struct Function: Decodable {
            struct Parameter: Decodable {
                let name: String
                let type: String
                let internalType: String
            }

            let type: String
            let name: String
            let inputs: [Parameter]
            let outputs: [Parameter]
            let stateMutability: String
        }

        let abi: [Function]
    }

    struct Bytecode: Decodable {
        let object: String
    }

    struct DeployedBytecode: Decodable {
        let object: String
    }

    let abi: [ABI.Function]
    let bytecode: Bytecode
    let deployedBytecode: DeployedBytecode
}

// Function to decode JSON data
func decodeContract(from jsonData: Data) -> Contract? {
    let decoder = JSONDecoder()
    do {
        let contract = try decoder.decode(Contract.self, from: jsonData)
        return contract
    } catch {
        print("Failed to decode JSON: \(error)")
        return nil
    }
}
