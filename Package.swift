// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AVPlayerControlUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "PlayerControl", targets: ["PlayerControl"]),
    ],
    targets: [
        .target(
            name: "PlayerControl",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
    ]
)
