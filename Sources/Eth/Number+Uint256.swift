import Foundation
import SwiftNumber

public extension Number {
    static let MAX_UINT_256: Number = "115792089237316195423570985008687907853269984665640564039457584007913129639935"

    var isMaxUint256: Bool {
        self == Number.MAX_UINT_256
    }
}
