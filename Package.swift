// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Eth",
    platforms: [
        .macOS(.v13),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v4),
        .macCatalyst(.v13),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Eth",
            targets: ["Eth"]
        ),
        .executable(
            name: "Geno",
            targets: ["Geno"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/legend-hq/SwiftNumber", branch: "13da63cad880c615e92ea0fe0b4319b83411156c"),
        .package(url: "https://github.com/hayesgm/SwiftKeccak.git", branch: "98a9d4a037dd62283977d5e0ef7d11c5612ff813"),
        .package(url: "https://github.com/apple/swift-syntax.git", from: "601.0.1"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Eth",
            dependencies: ["SwiftNumber", "SwiftKeccak"]
        ),
        .executableTarget(
            name: "Geno",
            dependencies: [
                "Eth",
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "EthTests",
            dependencies: ["Eth"]
        ),
        .testTarget(
            name: "GenoTests",
            dependencies: ["Geno", "Eth"]
        ),
    ]
)
