// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Years",
            targets: [
                "Year2022",
            ]
        ),
        .library(
            name: "Models",
            targets: [
                "Solution",
                "Division",
            ]
        ),
        .executable(
            name: "advent",
            targets: ["Commands"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.2"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.3"),
    ],
    targets: [
        .target(
            name: "Division",
            path: "Sources/Models/Division"
        ),
        .target(
            name: "Solution",
            dependencies: ["Year2022", "Division"],
            path: "Sources/Models/Solution"
        ),
        .target(
            name: "Year2022",
            dependencies: ["Division"],
            path: "Sources/Years/2022"
        ),
        .executableTarget(
            name: "Commands",
            dependencies: [
                "Solution",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
            ],
            swiftSettings: [.unsafeFlags(["-O"])]
        ),
    ]
)
