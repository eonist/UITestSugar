// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "UITestSugar",
    platforms: [.iOS(.v15), .macOS(.v10_15)],
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
