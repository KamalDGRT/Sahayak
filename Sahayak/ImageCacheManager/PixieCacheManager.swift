//
//  PixieCacheManager.swift
//  Sahayak
//  Reference & Credits: https://github.com/aumChauhan/PixieCacheKit.git
//

import Foundation
/// Manages image caching operations within PixieCacheKit.
///
/// Use `PixieCacheManager` to perform cache management tasks such as clearing cached data
/// and retrieving information about the cache directory size.
///
/// - Note: Use `clearCacheData()` and `getCacheDirectorySize()` methods if you are using file manager for caching images.
public class PixieCacheManager {
    private init() {}
    
    /// Remove all images from the cache directory.
    ///
    /// Use `clearCacheData()` to delete all cached images from cache directory.
    public static func clearCacheData() {
        CacheManager.shared.clearCacheData()
    }
    
    /// Calculate and return the total size of the cache directory in bytes.
    ///
    /// Use `getCacheDirectorySize()` to retrieve the total size of the cache directory, including all cached images and data.
    ///
    /// - Returns: The total size of the cache directory in bytes.
    public static func getCacheDirectorySize() -> Int {
        return CacheManager.shared.getCacheDirectorySize()
    }
}
