// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "LottoKit",
    platforms: [
        .macOS(.v12),
    ],
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
        .package(url: "git@github.com:pvieito/FoundationKit.git", .branch("master")),
        .package(url: "git@github.com:pvieito/LoggerKit.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
    ],
    targets: [
        .executableTarget(
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
