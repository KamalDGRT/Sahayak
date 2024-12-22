// swift-tools-version:5.9
//
// Package.swift
// Sahayak
//
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sahayak",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "Sahayak",
            targets: ["Sahayak"]
        )
    ],
    targets: [
        .target(
            name: "Sahayak",
            path: "Sources/Sahayak" // Source files directory
        ),
        .testTarget(
            name: "SahayakTests",
            dependencies: ["Sahayak"],
            path: "Tests/SahayakTests"
        )
    ]
)
