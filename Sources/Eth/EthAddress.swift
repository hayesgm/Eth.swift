import Foundation

/// EthAddress represents a wrapped 20-byte Ethereum address
public struct EthAddress: Equatable, ExpressibleByStringLiteral {
    let address: Data

    /// Creates an `EthAddress` from a `Data` object.
    ///
    /// - Parameter data: The raw data representing the Ethereum address. Must be 20 bytes long.
    /// - Returns: An optional `EthAddress` if the data is 20 bytes long, otherwise `nil`.
    public init?(_ data: Data) {
        guard data.count == 20 else {
            return nil
        }
        address = data
    }

    /// Creates an `EthAddress` from a hexadecimal string.
    ///
    /// - Parameter hex: A string containing the hexadecimal representation of the Ethereum address.
    /// - Returns: An optional `EthAddress` if the string is a valid 20-byte hex representation, otherwise `nil`.
    public init?(hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(data)
    }

    /// Creates an `EthAddress` from a string literal.
    ///
    /// - Parameter value: A string literal containing the hexadecimal representation of the Ethereum address.
    /// - Returns: An `EthAddress` if the string is a valid 20-byte hex representation, otherwise triggers a fatal error.
    public init(stringLiteral value: StringLiteralType) {
        guard let data = Hex.parseHex(value), data.count == 20 else {
            fatalError("Invalid Ethereum Address")
        }
        address = data
    }
}
