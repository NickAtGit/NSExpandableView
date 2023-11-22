// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "NSExpandableView",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [.library(name: "NSExpandableView", targets: ["NSExpandableView"])],
    targets: [
        .target(name: "NSExpandableView"),
        .testTarget( name: "NSExpandableViewTests"),
    ]
)
