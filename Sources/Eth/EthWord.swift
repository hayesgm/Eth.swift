import BigInt
import Foundation

public struct EthWord: Codable, Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    let data: Data

    public init?(_ data: Data) {
        guard data.count == 32 else {
            return nil
        }
        self.data = data
    }

    public init?(hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(data)
    }

    public init?(dataExtending data: Data, withPadding paddingValue: UInt8 = 0) {
        let paddingSize = 32 - data.count
        guard paddingSize >= 0 else {
            return nil
        }
        let padding = Data(repeating: paddingValue, count: paddingSize)
        self.init(padding + data)
    }

    public init?(hexExtending hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(dataExtending: data)
    }

    public init?(fromBigUInt value: BigUInt) {
        self.init(dataExtending: value.serialize())
    }

    /*
     import Eth
     import BigInt
     EthWord(fromBigInt: BigInt(-1))?.description
     EthWord(fromBigInt: BigInt(-2))?.description
     EthWord(fromBigInt: BigInt(-2))?.description
     */
    public init?(fromBigInt value: BigInt) {
        var data: Data

        if value.sign == .plus {
            data = value.serialize()
        } else {
            // Calculate the two's complement for negative values
            var serialized = (-(value + 1)).serialize().dropFirst(1)
            serialized = Data(serialized.map { ~$0 })
            data = serialized
        }

        self.init(dataExtending: data, withPadding: value.sign == .plus ? 0x00 : 0xFF)
    }

    public init?(fromInt value: Int) {
        self.init(fromBigInt: BigInt(value))
    }

    public init?(fromUInt8 value: UInt8) {
        self.init(fromBigInt: BigInt(value))
    }

    public init(stringLiteral value: StringLiteralType) {
        guard let data = Hex.parseHex(value), data.count == 32 else {
            fatalError("Invalid Ethereum Word: \(value)")
        }
        self.data = data
    }

    public var description: String {
        "EthWord[\(Hex.toShortHex(data))]"
    }

    public func toBigUInt() -> BigUInt {
        return BigUInt(data)
    }

    private static let maxInt256 = BigInt(1) << 256

    private func bitwise(_ fn: (UInt8) -> UInt8) -> Data {
        var result = Data(count: 32)
        for i in 0 ..< 32 {
            result[i] = fn(data[i])
        }
        return result
    }

    public func toBigInt() -> BigInt {
        // Convert EthWord number to a BigInt
        // As EthWords are stored as two's complement, we will
        // need to convert this to a form that BigInt recognizes,
        // which is [sign_byte, ...bytes]
        if data[0] & 0x80 != 0 {
            // Negative number handling
            // Create an inverted copy of the data
            var invertedData = Data(count: 32)
            for i in 0 ..< 32 {
                invertedData[i] = ~data[i]
            }

            // Convert the inverted data to a BigInt and add 1 to get the positive equivalent
            var positiveValue = BigInt(Data([0]) + invertedData) + 1

            // Negate the value to get the original negative number
            positiveValue = -positiveValue

            return positiveValue
        } else {
            return BigInt(data)
        }
    }

    // EthWord(hex: "0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE")!.toBigInt().description
    // EthWord(hex: "0x8000000000000000000000000000000000000000000000000000000000000000")!.toBigInt().description

    // Functions we need:
    //   EthWord (two's complemented serialized) -> BigInt toBigInt()
    //   BigInt -> EthWord (two's complement serialized)   init(fromBigInt:)

    public func toInt() -> Int? {
        let bigInt = toBigUInt()
        if bigInt <= BigUInt(Int.max) {
            return Int(bigInt)
        } else {
            return nil
        }
    }
}
