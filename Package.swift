// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Injector",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_14),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Injector",
            targets: ["Injector"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Injector",
            dependencies: [
                "Factory"
            ]),
        .testTarget(
            name: "InjectorTests",
            dependencies: ["Injector"]),
    ]
)
