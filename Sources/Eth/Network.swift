import BigInt
import Foundation

/// A ``Network`` represents different Ethereum networks (e.g. `Mainnet` or `Base`).
public enum Network: Codable, Equatable, Hashable, Identifiable {
    case arbitrum
    case arbitrumSepolia
    case avalanche
    case base
    case baseSepolia
    case ethereum
    case linea
    case lineaSepolia
    case optimism
    case polygon
    case scroll
    case scrollSepolia
    case sepolia
    case unknown(BigInt)

    public var id: String {
        description
    }

    public var description: String {
        switch self {
        case .arbitrum:
            "Arbitrum"
        case .arbitrumSepolia:
            "Arbitrum (Sepolia)"
        case .avalanche:
            "Avalanche"
        case .base:
            "Base"
        case .baseSepolia:
            "Base (Sepolia)"
        case .ethereum:
            "Ethereum"
        case .linea:
            "Linea"
        case .lineaSepolia:
            "Linea (Sepolia)"
        case .optimism:
            "Optimism"
        case .polygon:
            "Polygon"
        case .scroll:
            "Scroll"
        case .scrollSepolia:
            "Scroll (Sepolia)"
        case .sepolia:
            "Sepolia"
        case let .unknown(chainId):
            "Unknown (chainId=\(chainId.description))"
        }
    }

    /// Decodes from either an Int or an Int-String
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let value = try container.decode(String.self)
            guard let bigIntValue = BigInt(value) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid BigInt value")
            }
            self = Network.fromChainId(bigIntValue)
        } catch {
            let value = try container.decode(Int.self)
            self = Network.fromChainId(value)
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(chainId.description)
    }

    public static func fromChainId(_ chainId: Int) -> Self {
        fromChainId(BigInt(chainId))
    }

    /// Create `Network` from BigInt. `Unknown` is returned
    /// if the chainId  is not supported
    public static func fromChainId(_ chainId: BigInt) -> Self {
        switch chainId {
        case Network.arbitrum.chainId:
            .arbitrum
        case Network.arbitrumSepolia.chainId:
            .arbitrumSepolia
        case Network.avalanche.chainId:
            .avalanche
        case Network.base.chainId:
            .base
        case Network.baseSepolia.chainId:
            .baseSepolia
        case Network.ethereum.chainId:
            .ethereum
        case Network.linea.chainId:
            .linea
        case Network.lineaSepolia.chainId:
            .lineaSepolia
        case Network.optimism.chainId:
            .optimism
        case Network.polygon.chainId:
            .polygon
        case Network.scroll.chainId:
            .scroll
        case Network.scrollSepolia.chainId:
            .scrollSepolia
        case Network.sepolia.chainId:
            .sepolia
        default:
            .unknown(chainId)
        }
    }

    public var chainId: BigInt {
        switch self {
        case .arbitrum:
            BigInt(42161)
        case .arbitrumSepolia:
            BigInt(421_614)
        case .avalanche:
            BigInt(43114)
        case .base:
            BigInt(8453)
        case .baseSepolia:
            BigInt(84532)
        case .ethereum:
            BigInt(1)
        case .linea:
            BigInt(59144)
        case .lineaSepolia:
            BigInt(59141)
        case .optimism:
            BigInt(10)
        case .polygon:
            BigInt(137)
        case .scroll:
            BigInt(534_352)
        case .scrollSepolia:
            BigInt(534_351)
        case .sepolia:
            BigInt(11_155_111)
        case .unknown:
            BigInt(0)
        }
    }

    public var explorerName: String? {
        switch self {
        case .arbitrum:
            "Arbiscan"
        case .arbitrumSepolia:
            "Arbiscan (Sepolia)"
        case .avalanche:
            "Snowtrace"
        case .base:
            "Basescan"
        case .baseSepolia:
            "Basescan (Sepolia)"
        case .ethereum:
            "Etherscan"
        case .linea:
            "Lineascan"
        case .lineaSepolia:
            "Lineascan (Sepolia)"
        case .optimism:
            "OP Scan"
        case .polygon:
            "Polygonscan"
        case .scroll:
            "Scrollscan"
        case .scrollSepolia:
            "Scrollscan (Sepolia)"
        case .sepolia:
            "Etherscan (Sepolia)"
        case .unknown:
            nil
        }
    }

    public var explorerUrl: URL? {
        switch self {
        case .arbitrum:
            URL(string: "https://arbiscan.io")
        case .arbitrumSepolia:
            URL(string: "https://sepolia.arbiscan.io")
        case .avalanche:
            URL(string: "https://snowtrace.io")
        case .base:
            URL(string: "https://basescan.org")
        case .baseSepolia:
            URL(string: "https://sepolia.basescan.org")
        case .ethereum:
            URL(string: "https://etherscan.io")
        case .linea:
            URL(string: "https://lineascan.build")
        case .lineaSepolia:
            URL(string: "https://sepolia.lineascan.build")
        case .optimism:
            URL(string: "https://optimistic.etherscan.io")
        case .polygon:
            URL(string: "https://polygonscan.com")
        case .scroll:
            URL(string: "https://scrollscan.com")
        case .scrollSepolia:
            URL(string: "https://sepolia.scrollscan.com")
        case .sepolia:
            URL(string: "https://sepolia.etherscan.io")
        case .unknown:
            nil
        }
    }
}
