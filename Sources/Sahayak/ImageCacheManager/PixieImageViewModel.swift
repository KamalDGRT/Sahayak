//
//  PixieImageViewModel.swift
//  Sahayak
//  Reference & Credits: https://github.com/aumChauhan/PixieCacheKit.git
//

#if !os(macOS)
import SwiftUI

/// Manages image fetching and caching operations.
@MainActor class PixieImageViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let urlString: String
    private let imageKey: String
    private let networkService: NetworkService
    
    /// The fetched image, if available.
    @Published var image: UIImage? = nil
    
    /// Indicates whether the image is currently being fetched.
    @Published var isLoading: Bool = false
    
    // MARK: - Initializer
    
    init(
        url: String,
        key: String,
        networkService: NetworkService
    ) {
        urlString = url
        imageKey = key
        self.networkService = networkService
        getImage()
    }
}

// MARK: - Image Handling
private extension PixieImageViewModel {
    /// Retrieve a cached image on basis of storage location.
    func getImage() {
        switch CacheManager.shared.storageLocation {
        case .memory:
            fetchImageFromMemoryCache()
        case .fileManager:
            fetchImageFromCacheDirectory()
        }
    }
    
    /// Download image from specified `urlString`.
    func downloadImage() {
        if CacheManager.shared.debugPrint {
            print("PIXIE_CACHE_KIT_DEBUG: DOWNLOADING IMAGE.")
        }
        
        Task {
            withAnimation { isLoading = true }
            
            do {
                let downloadedImage = try await networkService.asyncImageDownload(urlString: urlString)
                
                withAnimation { image = downloadedImage }
                
                // Appending a cached image on basis of storage location
                switch CacheManager.shared.storageLocation {
                case .fileManager:
                    CacheManager.shared.appendImageToCacheDirectory(
                        image: downloadedImage,
                        key: imageKey
                    )
                case .memory:
                    CacheManager.shared.addCachedImage(
                        image: downloadedImage,
                        key: imageKey
                    )
                }
            } catch {
                Log.e("PIXIE_CACHE_KIT_DEBUG: FAIL TO DOWNLOAD IMAGE \(error.localizedDescription).")
            }
            
            withAnimation { isLoading = false }
        }
    }
}

// MARK: Image Fetching Part
private extension PixieImageViewModel {
    func fetchImageFromCacheDirectory() {
        if let savedImage = CacheManager.shared.getImageFromCacheDirectory(key: imageKey) {
            image = savedImage
            
            if CacheManager.shared.debugPrint {
                print("PIXIE_CACHE_KIT_DEBUG: RETRIEVING IMAGE FROM FILE MANAGER.")
            }
        } else {
            // Downloading image, incase retrieving cached images goes fails.
            downloadImage()
        }
    }
    
    func fetchImageFromMemoryCache() {
        if let savedImage = CacheManager.shared.getCachedImage(key: imageKey) {
            image = savedImage
            
            if CacheManager.shared.debugPrint {
                print("PIXIE_CACHE_KIT_DEBUG: RETRIEVING IMAGE FROM NSCACHE.")
            }
        } else {
            // Downloading image, incase retrieving cached images goes fails.
            downloadImage()
            
            if CacheManager.shared.debugPrint {
                print("PIXIE_CACHE_KIT_DEBUG: DOWNLOADING IMAGE.")
            }
        }
    }
}
#endif
