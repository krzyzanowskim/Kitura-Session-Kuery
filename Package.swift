// swift-tools-version:4.0
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
        .package(url: "https://github.com/IBM-Swift/Kitura-Session.git", from: "2.1.0"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "KituraSessionKuery",
            dependencies: ["KituraSession", "SwiftKuery"])
    ]
)
