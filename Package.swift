// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "LottoKit",
    products: [
        .executable(
            name: "LottoTool",
            targets: ["LottoTool"]
        ),
        .library(
            name: "LottoKit",
            targets: ["LottoKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/FoundationKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/LoggerKit.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
    ],
    targets: [
        .target(
            name: "LottoTool",
            dependencies: ["LottoKit", "FoundationKit", .product(name: "ArgumentParser", package: "swift-argument-parser")],
            path: "LottoTool"
        ),
        .target(
            name: "LottoKit",
            dependencies: ["LoggerKit"],
            path: "LottoKit"
        ),
        .testTarget(
            name: "LottoKitTests",
            dependencies: ["LottoKit"]
        )
    ]
)
