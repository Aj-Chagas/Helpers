// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Network",
    platforms: [
         .macOS(.v10_15),
         .iOS(.v13)
    ],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]
        ),
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: []
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"],
            resources: [.process("JSONResources")]
        ),
    ]
)
