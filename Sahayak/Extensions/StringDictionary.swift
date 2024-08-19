//
// StringDictionary.swift
// Sahayak
//

import Foundation

extension StringDictionary {
    var urlEncodedString: String {
        var urlComponents = URLComponents(string: "")
        urlComponents?.queryItems = self.map {
            URLQueryItem(name: $0, value: $1)
        }
        return urlComponents?.query ?? ""
    }
    
    func isFormUrlEncoded() -> Bool {
        return self["Content-Type"]?.lwr() == "application/x-www-form-urlencoded"
    }
}
