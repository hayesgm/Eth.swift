import Foundation

/// `EthAddress` represents a 20-byte Ethereum address
public struct EthAddress: Codable, Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    /// The 20-byte `Hex` struct representing the Ethereum address
    public let address: Hex

    /// Creates an `EthAddress` from a `Hex` object.
    ///
    /// - Parameter hex: The raw hex representing the Ethereum address. Must be exactly 20-bytes long.
    /// - Returns: An optional `EthAddress` if the data is 20-bytes long, otherwise `nil`.
    public init?(_ hex: Hex) {
        guard hex.data.count == 20 else {
            return nil
        }
        address = hex
    }

    /// Creates an `EthAddress` from a `Data` object.
    ///
    /// - Parameter data: A `Data` containing the hexadecimal representation of the Ethereum address.
    /// - Returns: An optional `EthAddress` if the string is a valid 20-byte hex representation, otherwise `nil`.
    public init?(fromData data: Data) {
        self.init(Hex(data))
    }

    /// Creates an `EthAddress` from a hexadecimal string.
    ///
    /// - Parameter hex: A string containing the hexadecimal representation of the Ethereum address.
    /// - Returns: An optional `EthAddress` if the string is a valid 20-byte hex representation, otherwise `nil`.
    public init?(fromHexString hexString: String) {
        guard let hex = Hex(hex: hexString) else {
            return nil
        }
        self.init(hex)
    }

    /// Creates an `EthAddress` from a string literal.
    ///
    /// - Parameter value: A string literal containing the hexadecimal representation of the Ethereum address.
    /// - Returns: An `EthAddress` if the string is a valid 20-byte hex representation, otherwise triggers a fatal error.
    public init(stringLiteral value: StringLiteralType) {
        guard let hex = Hex(hex: value), hex.count == 20 else {
            fatalError("Invalid Ethereum Address")
        }
        address = hex
    }

    /// Decodes an `EthAddress` from a hex string
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Hex.self)
        if data.count != 20 {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "EthAddress must be exactly 20-bytes")
        }
        address = data
    }

    /// Encodes `EthAddress` to a hex string
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(hex)
    }

    /// The address represented as a hexadecimal string.
    public var description: String {
        hex
    }

    /// The address represented as a hexadecimal string.
    public var hex: String {
        address.hex
    }

    /// The Data represented by this address.
    public var data: Data {
        address.data
    }
}
