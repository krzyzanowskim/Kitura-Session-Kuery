// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Kitura-Session-Kuery",
    products: [
        .library(
            name: "KituraSessionKuery",
            targets: ["KituraSessionKuery"])
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura-Session.git", from: "3.3.4"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", from: "3.0.1")
    ],
    targets: [
        .target(
            name: "KituraSessionKuery",
            dependencies: ["KituraSession", "SwiftKuery"])
    ]
)
