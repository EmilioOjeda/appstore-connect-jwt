// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "AppStoreConnectToken",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "AppStoreConnectToken",
            targets: ["AppStoreConnectToken"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/vapor/jwt-kit.git",
            from: "4.7.0"),
    ],
    targets: [
        .target(
            name: "AppStoreConnectToken",
            dependencies: [
                .product(name: "JWTKit", package: "jwt-kit"),
            ]),
    ]
)
