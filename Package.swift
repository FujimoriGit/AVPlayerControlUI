// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AVPlayerControlUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Playback", targets: ["Playback"]),
    ],
    targets: [
        .target(
            name: "Playback",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
    ]
)
