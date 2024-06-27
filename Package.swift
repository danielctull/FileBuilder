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
        .library(name: "FileBuilderKit", targets: ["FileBuilderKit"]),
        .library(name: "FileBuilderTesting", targets: ["FileBuilderTesting"]),
    ],
    targets: [

        .target(
            name: "FileBuilderKit"),

        .target(
            name: "FileBuilderTesting",
            dependencies: ["FileBuilderKit"]),

        .testTarget(
            name: "FileBuilderTests",
            dependencies: [
                "FileBuilderKit",
                "FileBuilderTesting",
            ]),
    ]
)
