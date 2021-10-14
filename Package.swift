// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewRepresentationEdition",
    products: [
        .library(name: "ViewRepresentationEdition", targets: ["ViewRepresentationEdition"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ViewRepresentationEdition", dependencies: []),
        .testTarget(name: "ViewRepresentationEditionTests", dependencies: ["ViewRepresentationEdition"]),
    ]
)
