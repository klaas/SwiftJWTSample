// swift-tools-version:5.0
import PackageDescription

let package = Package(
	name: "SwiftJWTSample",
	platforms: [
		.macOS(.v10_13),
	],
	dependencies: [
		.package(url: "https://github.com/IBM-Swift/Swift-JWT.git", from: "3.5.0"),
	],
	targets: [
		.target(name: "generateToken", dependencies: ["SwiftJWT"]),
	],
	swiftLanguageVersions: [.v5]
)
