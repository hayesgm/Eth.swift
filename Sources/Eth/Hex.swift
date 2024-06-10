import Foundation

/// Hex provides utilities for parsing and encoding hex from and into `Data` values.
public enum Hex {
    /// Represents an error parsing hex
    public enum HexError: Error {
        case invalidHex(String)
    }

    /**
     * Parses a hexadecimal string and returns the corresponding `Data`.
     *
     * This method processes both prefixed (`0x`) and non-prefixed hexadecimal strings.
     *
     * Example:
     * ```
     * if let data = Hex.parseHex("0x0A1B2C") {
     *     print(data)  // <0a1b2c>
     * }
     * ```
     *
     * - Parameter hex: The hexadecimal string to parse.
     * - Returns: The `Data` representation of the hexadecimal string, or `nil` if the string is not valid hexadecimal.
     */
    public static func parseHex(_ hex: String) -> Data? {
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
     * if let data = try Hex.hex("0x0A1B2C") {
     *     print(data)  // <0a1b2c>
     * }
     * ```
     *
     * - Parameter hex: The hexadecimal string to parse.
     * - Returns: The `Data` representation of the hexadecimal string.
     */
    public static func hex(_ hexInput: String) throws -> Data {
        if let hex = parseHex(hexInput) {
            hex
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
