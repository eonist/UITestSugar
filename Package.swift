// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "UITestSugar",
    platforms: [.iOS(.v12), .macOS(.v10_13)],
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
