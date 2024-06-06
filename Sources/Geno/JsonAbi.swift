import Foundation

struct ABIElement: Codable {
    var name: String?
    var type: String
    var inputs: [ABIInput]?
    var outputs: [ABIOutput]?
    var stateMutability: String?
    var constant: Bool?
    var payable: Bool?
    var anonymous: Bool?

    enum CodingKeys: String, CodingKey {
        case name, type, inputs, outputs, stateMutability, constant, payable, anonymous
    }
}

struct ABIInput: Codable {
    var name: String
    var type: String
    var indexed: Bool?
    var components: [ABIInput]?
}

struct ABIOutput: Codable {
    var name: String
    var type: String
    var components: [ABIOutput]?
}

func decodeABI(from jsonFileName: String) -> [ABIElement]? {
    guard let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json"),
          let data = try? Data(contentsOf: url)
    else {
        print("Failed to load \(jsonFileName).json from bundle.")
        return nil
    }

    do {
        let decoder = JSONDecoder()
        let abiElements = try decoder.decode([ABIElement].self, from: data)
        return abiElements
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}
