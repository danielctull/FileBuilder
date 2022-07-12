// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FileGenerator",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "FileGenerator", targets: ["FileGenerator"]),
        .library(name: "SwiftGenerator", targets: ["SwiftGenerator"]),
    ],
    targets: [
        .target(name: "FileGenerator"),
        .testTarget(name: "FileGeneratorTests", dependencies: ["FileGenerator"]),

        .target(name: "SwiftGenerator", dependencies: ["FileGenerator"]),
        .testTarget(name: "SwiftGeneratorTests", dependencies: ["SwiftGenerator"]),
    ]
)
