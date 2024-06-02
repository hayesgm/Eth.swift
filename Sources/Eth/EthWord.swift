import BigInt
import Foundation

struct EthWord: Codable, Equatable, Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
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

    init?(dataExtending data: Data) {
        let paddingSize = 32 - data.count
        guard paddingSize >= 0 else {
            return nil
        }
        let padding = Data(repeating: 0, count: paddingSize)
        self.init(padding + data)
    }

    init?(hexExtending hex: String) {
        guard let data = Hex.parseHex(hex) else {
            return nil
        }
        self.init(dataExtending: data)
    }

    init?(fromBigUInt value: BigUInt) {
        self.init(dataExtending: value.serialize())
    }

    init?(fromBigInt value: BigInt) {
        self.init(dataExtending: value.serialize())
    }

    init?(fromInt value: Int) {
        self.init(fromBigInt: BigInt(value))
    }

    init?(fromUInt8 value: UInt8) {
        self.init(fromBigInt: BigInt(value))
    }

    init(stringLiteral value: StringLiteralType) {
        guard let data = Hex.parseHex(value), data.count == 32 else {
            fatalError("Invalid Ethereum Word: \(value)")
        }
        self.data = data
    }

    var description: String {
        "EthWord[\(Hex.toShortHex(data))]"
    }

    func toBigUInt() -> BigUInt {
        return BigUInt(data)
    }

    func toBigInt() -> BigInt {
        return BigInt(data)
    }

    func toInt() -> Int? {
        let bigInt = toBigUInt()
        if bigInt <= BigUInt(Int.max) {
            return Int(bigInt)
        } else {
            return nil
        }
    }
}
