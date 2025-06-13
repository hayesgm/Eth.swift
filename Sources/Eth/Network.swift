import Foundation
import SwiftNumber

/// A ``Network`` represents different Ethereum networks (e.g. `Mainnet` or `Base`).
public enum Network: Codable, Equatable, Hashable, Identifiable, Sendable {
    case alephZero
    case arbitrum
    case arbitrumSepolia
    case avalanche
    case base
    case baseSepolia
    case blast
    case bnbSmartChain
    case celo
    case ethereum
    case gnosis
    case hyperEVM
    case ink
    case lens
    case linea
    case lineaSepolia
    case lisk
    case mantle
    case mode
    case optimism
    case plume
    case polygon
    case redstone
    case scroll
    case scrollSepolia
    case sepolia
    case soneium
    case sonic
    case unichain
    case worldChain
    case zkSync
    case zora
    case unknown(Number)

    public var id: String {
        description
    }

    public var description: String {
        switch self {
        case .alephZero:
            "Aleph Zero"
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
        case .blast:
            "Blast"
        case .bnbSmartChain:
            "BNB Smart Chain"
        case .celo:
            "Celo"
        case .ethereum:
            "Ethereum"
        case .gnosis:
            "Gnosis"
        case .hyperEVM:
            "HyperEVM"
        case .ink:
            "Ink"
        case .lens:
            "Lens"
        case .linea:
            "Linea"
        case .lineaSepolia:
            "Linea (Sepolia)"
        case .lisk:
            "Lisk"
        case .mantle:
            "Mantle"
        case .mode:
            "Mode"
        case .optimism:
            "Optimism"
        case .plume:
            "Plume"
        case .polygon:
            "Polygon"
        case .redstone:
            "Redstone"
        case .scroll:
            "Scroll"
        case .scrollSepolia:
            "Scroll (Sepolia)"
        case .sepolia:
            "Sepolia"
        case .soneium:
            "Soneium"
        case .sonic:
            "Sonic"
        case .unichain:
            "Unichain"
        case .worldChain:
            "World Chain"
        case .zkSync:
            "ZkSync"
        case .zora:
            "Zora"
        case let .unknown(chainId):
            "Unknown (chainId=\(chainId.description))"
        }
    }

    /// Decodes from either an UInt or an UInt-String (Number)
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let value = try container.decode(String.self)
            guard let numberValue = Number(value) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid Number value")
            }
            self = Network.fromChainId(numberValue)
        } catch {
            let value = try container.decode(UInt.self)
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

    public static func fromChainId(_ chainId: UInt) -> Self {
        fromChainId(Number(chainId))
    }

    /// Create `Network` from Number. `Unknown` is returned
    /// if the chainId  is not supported
    public static func fromChainId(_ chainId: Number) -> Self {
        switch chainId {
        case Network.alephZero.chainId:
            .alephZero
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
        case Network.blast.chainId:
            .blast
        case Network.bnbSmartChain.chainId:
            .bnbSmartChain
        case Network.celo.chainId:
            .celo
        case Network.ethereum.chainId:
            .ethereum
        case Network.gnosis.chainId:
            .gnosis
        case Network.hyperEVM.chainId:
            .hyperEVM
        case Network.ink.chainId:
            .ink
        case Network.lens.chainId:
            .lens
        case Network.linea.chainId:
            .linea
        case Network.lineaSepolia.chainId:
            .lineaSepolia
        case Network.lisk.chainId:
            .lisk
        case Network.mantle.chainId:
            .mantle
        case Network.mode.chainId:
            .mode
        case Network.optimism.chainId:
            .optimism
        case Network.plume.chainId:
            .plume
        case Network.polygon.chainId:
            .polygon
        case Network.redstone.chainId:
            .redstone
        case Network.scroll.chainId:
            .scroll
        case Network.scrollSepolia.chainId:
            .scrollSepolia
        case Network.sepolia.chainId:
            .sepolia
        case Network.soneium.chainId:
            .soneium
        case Network.sonic.chainId:
            .sonic
        case Network.unichain.chainId:
            .unichain
        case Network.worldChain.chainId:
            .worldChain
        case Network.zkSync.chainId:
            .zkSync
        case Network.zora.chainId:
            .zora
        default:
            .unknown(chainId)
        }
    }

    public var chainId: Number {
        switch self {
        case .alephZero:
            Number(41455)
        case .arbitrum:
            Number(42161)
        case .arbitrumSepolia:
            Number(421_614)
        case .avalanche:
            Number(43114)
        case .base:
            Number(8453)
        case .baseSepolia:
            Number(84532)
        case .blast:
            Number(81457)
        case .bnbSmartChain:
            Number(56)
        case .celo:
            Number(42220)
        case .ethereum:
            Number(1)
        case .gnosis:
            Number(100)
        case .hyperEVM:
            Number(999)
        case .ink:
            Number(57073)
        case .lens:
            Number(232)
        case .linea:
            Number(59144)
        case .lineaSepolia:
            Number(59141)
        case .lisk:
            Number(1135)
        case .mantle:
            Number(5000)
        case .mode:
            Number(34443)
        case .plume:
            Number(98865)
        case .optimism:
            Number(10)
        case .polygon:
            Number(137)
        case .redstone:
            Number(690)
        case .scroll:
            Number(534_352)
        case .scrollSepolia:
            Number(534_351)
        case .soneium:
            Number(1868)
        case .sonic:
            Number(146)
        case .sepolia:
            Number(11_155_111)
        case .unichain:
            Number(130)
        case .worldChain:
            Number(480)
        case .zkSync:
            Number(324)
        case .zora:
            Number(7_777_777)
        case .unknown:
            Number(0)
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
        case .worldChain:
            "Worldscan"
        case .unichain:
            "Uniscan"
        case .unknown:
            nil
        case .alephZero, .blast, .bnbSmartChain, .celo, .gnosis, .hyperEVM,
             .ink, .lens, .lisk, .mantle, .mode, .plume, .redstone,
             .soneium, .sonic, .zkSync, .zora:
            "\(description) Explorer"
        }
    }

    public var explorerUrl: URL? {
        switch self {
        case .alephZero:
            URL(string: "https://evm-explorer.alephzero.org")
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
        case .blast:
            URL(string: "https://blastscan.io")
        case .bnbSmartChain:
            URL(string: "https://bscscan.com")
        case .celo:
            URL(string: "https://celoscan.io")
        case .ethereum:
            URL(string: "https://etherscan.io")
        case .gnosis:
            URL(string: "https://gnosisscan.io")
        case .hyperEVM:
            URL(string: "https://app.hyperliquid.xyz/explorer")
        case .ink:
            URL(string: "https://explorer.inkonchain.com")
        case .lens:
            URL(string: "https://explorer.lens.xyz")
        case .linea:
            URL(string: "https://lineascan.build")
        case .lineaSepolia:
            URL(string: "https://sepolia.lineascan.build")
        case .lisk:
            URL(string: "https://blockscout.lisk.com")
        case .mantle:
            URL(string: "https://mantlescan.xyz")
        case .mode:
            URL(string: "https://explorer.mode.network")
        case .plume:
            URL(string: "https://explorer.plumenetwork.xyz")
        case .optimism:
            URL(string: "https://optimistic.etherscan.io")
        case .polygon:
            URL(string: "https://polygonscan.com")
        case .redstone:
            URL(string: "https://explorer.redstone.xyz")
        case .scroll:
            URL(string: "https://scrollscan.com")
        case .scrollSepolia:
            URL(string: "https://sepolia.scrollscan.com")
        case .sepolia:
            URL(string: "https://sepolia.etherscan.io")
        case .soneium:
            URL(string: "https://soneium.blockscout.com")
        case .sonic:
            URL(string: "https://sonicscan.org")
        case .unichain:
            URL(string: "https://uniscan.xyz")
        case .worldChain:
            URL(string: "https://worldscan.org/")
        case .zkSync:
            URL(string: "https://zksync.blockscout.com")
        case .zora:
            URL(string: "https://explorer.zora.energy")
        case .unknown:
            nil
        }
    }
}
