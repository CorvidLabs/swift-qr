// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-qr",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "SwiftQR",
            targets: ["SwiftQR"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/CorvidLabs/swift-ascii.git",
            from: "0.1.0"
        ),
        .package(
            url: "https://github.com/tayloraswift/swift-png.git",
            from: "4.4.0"
        ),
        .package(
            url: "https://github.com/swiftlang/swift-docc-plugin",
            from: "1.4.0"
        ),
    ],
    targets: [
        .target(
            name: "SwiftQR",
            dependencies: [
                .product(name: "ASCIIPixelArt", package: "swift-ascii"),
                .product(name: "PNG", package: "swift-png"),
            ]
        ),
        .executableTarget(
            name: "qr-gen",
            dependencies: ["SwiftQR"]
        ),
        .testTarget(
            name: "SwiftQRTests",
            dependencies: ["SwiftQR"]
        ),
    ]
)
