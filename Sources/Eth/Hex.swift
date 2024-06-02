import Foundation

enum Hex {
    static func parseHex(_ hex: String) -> Data? {
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

    static func toHex(_ data: Data) -> String {
        return "0x" + data.map { String(format: "%02x", $0) }.joined()
    }

    static func toShortHex(_ data: Data) -> String {
        let hexString = data.map { String(format: "%02x", $0) }.joined()
        let trimmedHexString = hexString.drop { $0 == "0" }

        // If the string is empty after trimming (i.e., it was all zeros), return "0x0"
        return "0x" + (trimmedHexString.isEmpty ? "0" : String(trimmedHexString))
    }
}
