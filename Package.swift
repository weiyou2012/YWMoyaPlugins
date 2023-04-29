// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "YWMoyaPlugins",
    platforms: [
      .iOS(.v11)
    ],
    products: [
        .library(
            name: "YWMoyaPlugins",
            targets: ["YWMoyaPlugins"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "14.0.0"),
    ],
    targets: [
        .target(
            name: "YWMoyaPlugins",
            dependencies: [],
            path: "YWMoyaPlugins/Classes"
        ),
        .testTarget(
            name: "YWMoyaPluginsTests",
            dependencies: ["YWMoyaPlugins"]),
    ]
)
