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
				"Year2023"
			]
		),
		.library(
			name: "Models",
			targets: [
				"Solution",
				"Divisions"
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
			name: "Divisions",
			path: "Sources/Models/Divisions"
		),
		.target(
			name: "Solution",
			dependencies: [
				"Year2022", 
				"Year2023"
			],
			path: "Sources/Models/Solution"
		),
		.target(
			name: "Year2022",
			dependencies: [
				"Divisions",
				.product(name: "Algorithms", package: "swift-algorithms"),
				.product(name: "Collections", package: "swift-collections")
			],
			path: "Sources/Years/2022"
		),
		.target(
			name: "Year2023",
			dependencies: [
				"Divisions",
				.product(name: "Algorithms", package: "swift-algorithms"),
				.product(name: "Collections", package: "swift-collections")
			],
			path: "Sources/Years/2023"
		),
		.executableTarget(
			name: "Commands",
			dependencies: [
				"Solution",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			],
			swiftSettings: [.unsafeFlags(["-O"])]
		),
	]
)
