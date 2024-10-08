//
//  JSON.swift
//  Sahayak
//

import Foundation

struct Json {
    static var encoder = JSONEncoder()
    static var decoder = JSONDecoder()
}

public extension Data {
    func jsonDecoder<T: Codable>() -> T? {
        return try? Json.decoder.decode(T.self, from: self)
    }
    
    func decodeJSON<T: Codable>() -> T {
        guard let decodedData: T = jsonDecoder() else {
            fatalError("Failed to decode data to \(T.self).")
        }
        return decodedData
    }
    
    var toString: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
    
    var jsonString: String {
        var result = ""
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            result = jsonData.toString
        }
        return result
    }
}

public extension String {
    func decodeJSON<T: Codable>() -> T {
        
        guard let jsonData = self.data(using: .utf8) else {
            fatalError("Failed to parse data from the JSON string.")
        }
        
        let decodedData: T = jsonData.decodeJSON()
        return decodedData
    }
}

public extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    var toJsonString: String {
        return jsonData?.toString ?? "{}"
    }
}

public extension Encodable {
    /// https://stackoverflow.com/a/46597941
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: JsonDictionary {
        return (try? JSONSerialization.jsonObject(with: Json.encoder.encode(self))) as? JsonDictionary ?? [:]
    }
    
    var toJsonString: String {
        return self.dictionary.toJsonString
    }
}
