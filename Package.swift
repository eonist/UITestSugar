// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "UITestSugar",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "UITestSugar",
            targets: ["UITestSugar"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UITestSugar",
            dependencies: [],
            linkerSettings: [.linkedFramework("XCTest")]
         ),
        .testTarget(
            name: "UITestSugarTests",
            dependencies: ["UITestSugar"])
    ]
)
