// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "LottoKit",
    products: [
        .executable(name: "LottoTool", targets: ["LottoTool"]),
        .library(name: "LottoKit", targets: ["LottoKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/CommandLineKit.git", .branch("master")),
        .package(url: "https://github.com/pvieito/LoggerKit.git", .branch("master")),
    ],
    targets: [
        .target(name: "LottoTool", dependencies: ["LottoKit", "CommandLineKit"], path: "LottoTool"),
        .target(name: "LottoKit", dependencies: ["LoggerKit"], path: "LottoKit")
    ]
)
