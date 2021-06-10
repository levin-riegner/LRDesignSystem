// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LRDesignSystem",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LRDesignSystem",
            targets: ["LRDesignSystem"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LRDesignSystem",
            dependencies: [],
            resources: [
                .process("Fonts/Lato-Black"),
                .process("Fonts/Lato-BlackItalic"),
                .process("Fonts/Lato-Bold"),
                .process("Fonts/Lato-BoldItalic"),
                .process("Fonts/Lato-Light"),
                .process("Fonts/Lato-LightItalic"),
                .process("Fonts/Lato-Regular"),
                .process("Fonts/Lato-RegularItalic"),
                .process("Fonts/Lato-Thin"),
                .process("Fonts/Lato-ThinItalic"),
                .process("Fonts/MarkOffcPro-Bold"),
                .process("Fonts/MarkOffcPro-BoldItalic"),
                .process("Fonts/MarkOffcPro-Book"),
                .process("Fonts/MarkOffcPro-BookItalic"),
                .process("Fonts/MarkOffcPro-CondHeavy"),
                .process("Fonts/MarkOffcPro-Heavy"),
                .process("Fonts/MarkOffcPro-HeavyItalic"),
                .process("Fonts/MarkOffcPro-Light"),
                .process("Fonts/MarkOffcPro-LightItalic"),
            ]
        ),
        .testTarget(
            name: "LRDesignSystemTests",
            dependencies: ["LRDesignSystem"]),
    ]
)
