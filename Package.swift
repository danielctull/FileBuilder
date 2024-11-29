// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "FileBuilder",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "FileBuilder", targets: ["FileBuilder"]),
        .library(name: "FileBuilderTesting", targets: ["FileBuilderTesting"]),
    ],
    targets: [

        .target(
            name: "FileBuilder"),

        .target(
            name: "FileBuilderTesting",
            dependencies: ["FileBuilder"]),

        .testTarget(
            name: "FileBuilderTests",
            dependencies: [
                "FileBuilder",
                "FileBuilderTesting",
            ]),
    ]
)
