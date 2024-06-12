import Foundation

/// Hex is a light wrapper around `Data` to make it easily convertable to and from hex strings.
public struct Hex: Codable, Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    let data: Data

    /// Represents an error parsing hex
    public enum HexError: Error, Equatable {
        case invalidHex(String)
    }

    /// Wraps a `Data` in a `Hex` object.
    ///
    /// - Parameter data: The raw data representing the data.
    /// - Returns: A `Hex` object.
    public init(_ data: Data) {
        self.data = data
    }

    /// Creates a `Hex` object from a hexadecimal string.
    ///
    /// - Parameter hex: A string containing the hexadecimal representation of the data.
    /// - Returns: An optional `Hex` if the string is valid hex, otherwise `nil`.
    public init?(hex: String) {
        guard let hexData = Hex.dataFromHexString(hex) else {
            return nil
        }
        self.init(hexData)
    }

    /// Creates a `Hex` from a string literal.
    ///
    /// - Parameter value: A string literal containing the hexadecimal representation of the data.
    /// - Returns: A `Hex` if the string is valid hex, otherwise triggers a fatal error.
    public init(stringLiteral value: StringLiteralType) {
        guard let hexData = Hex.dataFromHexString(value) else {
            fatalError("Invalid hex value: \(value)")
        }
        self.init(hexData)
    }

    /// An empty `Hex` value
    public static var empty = Hex(Data())

    /// A string representation of the `Hex` value.
    public var description: String {
        hex
    }

    /// Returns a hexadecimal `String` representing this `Hex` data
    ///
    /// Example:
    /// ```
    /// Hex(hex: "0x0aaa").hex == "0x0aaa"
    /// ```
    public var hex: String {
        Hex.toHex(data)
    }

    /// Returns a hexadecimal `String` representing this `Hex` data with leading zeros removed.
    ///
    /// Example:
    /// ```
    /// Hex(hex: "0x0aaa").shortHex == "0xaaa"
    /// Hex(hex: "0x0").shortHex == "0x0"
    /// ```
    public var shortHex: String {
        Hex.toShortHex(data)
    }

    /// Returns the number of bytes represented by this `Hex` value.
    ///
    /// Example:
    /// ```
    /// Hex(hex: "0x0aaa").count == 2
    /// ```
    public var count: Int {
        data.count
    }

    /// Returns true if the `Hex` string is empty (contains empty data)
    ///
    /// Example:
    /// ```
    /// Hex(hex: "0x0aaa").isEmpty == false
    /// Hex(hex: "").isEmpty == true
    /// ```
    public var isEmpty: Bool {
        data.isEmpty
    }

    /**
     * Parses a hexadecimal string and returns the corresponding `Data`.
     *
     * This method processes both prefixed (`0x`) and non-prefixed hexadecimal strings.
     *
     * Example:
     * ```
     * if let data = Hex.dataFromHexString("0x0A1B2C") {
     *     print(data)  // <0a1b2c>
     * }
     * ```
     *
     * - Parameter hex: The hexadecimal string to parse.
     * - Returns: The `Data` representation of the hexadecimal string, or `nil` if the string is not valid hexadecimal.
     */
    public static func dataFromHexString(_ hex: String) -> Data? {
        let hexStringPre = hex.hasPrefix("0x") ? String(hex.dropFirst(2)) : hex
        let hexString = hexStringPre.count % 2 == 0 ? hexStringPre : "0\(hexStringPre)"

        var data = Data()
        var index = hexString.startIndex

        for _ in 0 ..< (hexString.count / 2) {
            let nextIndex = hexString.index(index, offsetBy: 2)
            let byteString = hexString[index ..< nextIndex]
            if let byte = UInt8(byteString, radix: 16) {
                data.append(byte)
            } else {
                return nil
            }
            index = nextIndex
        }

        return data
    }

    /**
     * Parses a hexadecimal string and returns the corresponding `Data` or throws.
     *
     * This method processes both prefixed (`0x`) and non-prefixed hexadecimal strings.
     *
     * Example:
     * ```
     * if let data = try Hex.parseHex("0x0A1B2C") {
     *     print(data)  // <0a1b2c>
     * }
     * ```
     *
     * - Parameter hex: The hexadecimal string to parse.
     * - Returns: The `Data` representation of the hexadecimal string.
     */
    public static func parseHex(_ hexInput: String) throws -> Data {
        if let data = dataFromHexString(hexInput) {
            data
        } else {
            throw HexError.invalidHex(hexInput)
        }
    }

    /**
     * Converts `Data` to a hexadecimal string with a `0x` prefix.
     *
     * Example:
     * ```
     * let data = Data([0x0A, 0x1B, 0x2C])
     * let hexString = Hex.toHex(data)
     * print(hexString)  // "0x0a1b2c"
     * ```
     *
     * - Parameter data: The `Data` to convert to a hexadecimal string.
     * - Returns: A hexadecimal string representation of the `Data` with a `0x` prefix.
     */
    public static func toHex(_ data: Data) -> String {
        return "0x" + data.map { String(format: "%02x", $0) }.joined()
    }

    /**
     * Converts `Data` to a short hexadecimal string with a `0x` prefix, trimming leading zeros.
     *
     * If the `Data` represents zero (i.e., all bytes are zero), the result is `"0x0"`.
     *
     * Example:
     * ```
     * let data = Data([0x00, 0x01, 0x0A])
     * let shortHexString = Hex.toShortHex(data)
     * print(shortHexString)  // "0x10a"
     * ```
     *
     * - Parameter data: The `Data` to convert to a short hexadecimal string.
     * - Returns: A short hexadecimal string representation of the `Data` with a `0x` prefix.
     */
    public static func toShortHex(_ data: Data) -> String {
        let hexString = data.map { String(format: "%02x", $0) }.joined()
        let trimmedHexString = hexString.drop { $0 == "0" }

        // If the string is empty after trimming (i.e., it was all zeros), return "0x0"
        return "0x" + (trimmedHexString.isEmpty ? "0" : String(trimmedHexString))
    }
}
