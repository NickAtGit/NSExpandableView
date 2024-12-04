// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NSExpandableView",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [.library(name: "NSExpandableView", targets: ["NSExpandableView"])],
    targets: [
        .target(name: "NSExpandableView"),
        .testTarget( name: "NSExpandableViewTests"),
    ]
)
