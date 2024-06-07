import Foundation

public struct EthAddress: Equatable, ExpressibleByStringLiteral {
    let address: Data

    public init?(_ data: Data) {
        guard data.count == 20 else {
            return nil
        }
        address = data
    }

    public init?(hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(data)
    }

    public init(stringLiteral value: StringLiteralType) {
        guard let data = Hex.parseHex(value), data.count == 20 else {
            fatalError("Invalid Ethereum Address")
        }
        address = data
    }
}
