// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "AppImport",
    platforms: [.iOS("11.1")],
    products: [
        .library(
            name: "AppImport",
            targets: ["AppImport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/htmlprogrammist/EmojiPicker", .upToNextMajor(from: "1.0.3"))
    ],
    targets: [
        .target(
            name: "AppImport",
            dependencies: [
                .product(name: "EmojiPicker", package: "EmojiPicker")
            ]),
        .testTarget(
            name: "AppImportTests",
            dependencies: ["AppImport"]),
    ]
)
