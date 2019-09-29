// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitPlus",
    products: [
        // 🏰 Declarative UIKit wrapper inspired by SwiftUI
        .library(name: "UIKitPlus", targets: ["UIKitPlus"]),
        ],
    dependencies: [],
    targets: [
        .target(name: "UIKitPlus", dependencies: [], path: "Classes"),
//        .testTarget(name: "UIKitPlusTests", dependencies: ["UIKitPlus"]),
        ]
)
