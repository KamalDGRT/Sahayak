//
//  PixieImage.swift
//  Sahayak
//  Reference & Credits: https://github.com/aumChauhan/PixieCacheKit.git
//

import SwiftUI

/// Fetches and displays an image from a URL with caching support.
///
/// Use `PixieImage` to asynchronously fetch and display images from URLs while benefiting from caching to improve performance.
///
/// Example Usage:
/// ```swift
/// // Example with a placeholder view while image is loading
/// PixieImage("https://example.com/image.jpg", cacheKey: "uniqueKey") {
///     ProgressView()
/// }
///
/// // Example without a placeholder view
/// PixieImage("https://example.com/image.jpg", cacheKey: "uniqueKey")
/// ```
///
/// - Parameters:
///   - urlString: The URL string of the image to fetch and display.
///   - cacheKey: The cache key for the fetched image.
///
/// - Note: You can enhance your `PixieImage` view by using SwiftUI view modifiers to customize its appearance and behavior.
public struct PixieImage<Placeholder>: View where Placeholder: View {
    
    // MARK: - Properties
    
    let placeholder: Placeholder?
    @StateObject private var viewModel: PixieImageViewModel
    
    // MARK: - Initializers
    
    /// Initializes `PixieImage` with the image URL and cache key.
    ///
    /// - Parameters:
    ///   - urlString: The URL string of the image to fetch and display.
    ///   - key: The cache key for the fetched image.
    public init(
        _ urlString: String,
        key: String,
        networkService: NetworkService
    ) where Placeholder == EmptyView {
        _viewModel = StateObject(
            wrappedValue: PixieImageViewModel(
                url: urlString,
                key: key,
                networkService: networkService
            )
        )
        self.placeholder = nil
        
    }
    
    /// Initializes `PixieImage` with the image URL, cache key, and an optional placeholder view.
    ///
    /// - Parameters:
    ///   - urlString: The URL string of the image to fetch and display.
    ///   - key: The cache key for the fetched image.
    ///   - placeholder: An optional placeholder view while the image is being fetched.
    public init(
        _ urlString: String,
        key: String,
        networkService: NetworkService,
        @ViewBuilder placeholder: () -> Placeholder?
    ) {
        _viewModel = StateObject(
            wrappedValue: PixieImageViewModel(
                url: urlString,
                key: key,
                networkService: networkService
            )
        )
        self.placeholder = placeholder()
    }
    
    // MARK: - View Body
    public var body: some View {
        if viewModel.isLoading {
            if let placeholder {
                placeholder
            } else {
                ProgressView()
            }
        } else if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
        } else {
            Color.gray
        }
    }
}
