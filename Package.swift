// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AllergomatShared",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AllergomatShared",
            targets: ["AllergomatShared"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/coaoac/Localizer", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AllergomatShared",
            dependencies: [
                .product(name: "Localizer", package: "Localizer"),
            ])

    ]
)
