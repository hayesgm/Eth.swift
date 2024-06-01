import Foundation

struct EthAddress: ExpressibleByStringLiteral {
    let address: Data

    init?(_ data: Data) {
        guard data.count == 20 else {
            return nil
        }
        address = data
    }

    init?(hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(data)
    }

    init(stringLiteral value: StringLiteralType) {
        guard let data = Hex.parseHex(value), data.count == 20 else {
            fatalError("Invalid Ethereum Address")
        }
        address = data
    }
}
