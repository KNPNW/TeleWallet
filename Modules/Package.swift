// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
            .iOS(.v16)
        ],
    products: [
        .library(
            name: "Modules",
            targets: ["Theme", "Wallet", "Market", "Settings", "Authorization"])
    ],
    dependencies: [
        .package(url: "https://github.com/KNPNW/MnemonicGenerator.git", from: "0.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Theme",
            dependencies: [],
            path: "Sources/Theme"
        ),
        .target(
            name: "Wallet",
            dependencies: ["Theme", "MnemonicGenerator"],
            path: "Sources/Wallet"
        ),
        .target(
            name: "Market",
            dependencies: [],
            path: "Sources/Market"
        ),
        .target(
            name: "Settings",
            dependencies: [],
            path: "Sources/Settings"
        ),
        .target(
            name: "Authorization",
            dependencies: ["Theme", "MnemonicGenerator"],
            path: "Sources/Authorization"
        )
    ]
)
