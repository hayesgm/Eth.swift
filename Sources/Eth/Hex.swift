import Foundation

enum Hex {
    static func parseHex(_ hex: String) -> Data? {
        let hexString = hex.hasPrefix("0x") ? String(hex.dropFirst(2)) : hex
        guard hexString.count % 2 == 0 else { return nil }

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
}
