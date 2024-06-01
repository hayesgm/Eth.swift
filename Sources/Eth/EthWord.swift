import Foundation

struct EthWord: Codable, Comparable {
    let data: Data

    init?(_ data: Data) {
        guard data.count == 32 else {
            return nil
        }
        self.data = data
    }

    init?(hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(data)
    }

    init?(hexExtending _: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        let paddingSize = 32 - data.count
        guard paddingSize > 0 else {
            return nil
        }
        let padding = Data(repeating: 0, count: paddingSize)
        self.init(padding + data)
    }

    init(stringLiteral value: StringLiteralType) {
        guard let data = Hex.parseHex(value), data.count == 32 else {
            fatalError("Invalid Ethereum Word")
        }
        self.data = data
    }
}
