// swift-tools-version:5.7

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
        .library(name: "FileTester", targets: ["FileTester"]),
    ],
    targets: [

        .target(
            name: "FileBuilder"),

        .target(
            name: "FileTester",
            dependencies: ["FileBuilder"]),

        .testTarget(
            name: "FileBuilderTests",
            dependencies: ["FileBuilder", "FileTester"]),
    ]
)
