// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "chatbot-builder",
    dependencies: [],
    targets: [
        .target(
            name: "chatbot-builder",
            dependencies: ["ChatbotKit"]),
        .target(
            name: "ChatbotKit",
            dependencies: []
        )
    ]
)
