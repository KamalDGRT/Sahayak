//
//  Bundle.swift
//  Sahayak
//

import Foundation

public extension Bundle {
    /// Returns json content present in a file to its corresponding JSON codable struct.
    /// - Parameter file: Name of the JSON file
    /// - Returns: the decoded file content to corrresponding Codable struct
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
