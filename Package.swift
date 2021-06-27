// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "UITestSugar",
    platforms: [.iOS(.v13), .macOS(.v10_14)],
    products: [
        .library(
            name: "UITestSugar",
            targets: ["UITestSugar"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UITestSugar",
            dependencies: []),
        .testTarget(
            name: "UITestSugarTests",
            dependencies: ["UITestSugar"])
    ]
)
