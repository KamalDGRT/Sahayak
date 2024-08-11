//
//  ImageUtils.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import Foundation

/// Represents supported image formats in PixieCacheKit.
public enum ImageFormat: String {
    /// Stores images in JPEG format.
    case jpeg = ".jpeg"
    
    /// Stores images in PNG format.
    case png = ".png"
}

/// Represents a different storage options for images in PixieCacheKit.
///
/// - Note: Use `memory` for storing images in NSCache for quick access and reduced load times,
///   suitable for frequently accessed or smaller images. Use `fileManager` for larger images
///   or less frequently accessed images, storing them in the file manager's cache directory
///   for persistent storage.
public enum ImageStorageLocation {
    /// Store images in NSCache for fast access.
    case memory
    
    /// Store images in the file manager's cache directory for persistent storage.
    case fileManager
}
