// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSFML",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftSFML",
            targets: ["SwiftSFML"]),
        .executable(name: "SwiftSFML Demo", targets: ["Demo"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/vykrill/CSFML.git", from: "0.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        //.target(name: "SSFMLSystem", dependencies: ["CSFML"]),
        .target(
            name: "SwiftSFML",
            dependencies: ["CSFML"]),
        .testTarget(
            name: "SwiftSFMLTests",
            dependencies: ["SwiftSFML"]),
        .target(name: "Demo", dependencies: [.target(name: "SwiftSFML")])
    ]
)
