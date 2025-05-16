// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "AppEnvironmentDetector",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AppEnvironmentDetector",
            targets: ["AppEnvironmentDetector"]
        ),
    ],
    dependencies: [
        // No dependencies needed
    ],
    targets: [
        .target(
            name: "AppEnvironmentDetector",
            dependencies: []
        ),
        .testTarget(
            name: "AppEnvironmentDetectorTests",
            dependencies: ["AppEnvironmentDetector"]
        ),
    ]
)
