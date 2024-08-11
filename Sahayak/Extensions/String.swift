//
//  String.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import Foundation

extension String {
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    var isNotBlank: Bool {
        get {
            return !self.isBlank
        }
    }
    
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
}


extension String {
    func convertDateFormat(
        from sourceFormat: String = "yyyy-MM-dd'T'HH:mm:ss",
        to destinationFormat: String = "dd-MM-yyyy"
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = destinationFormat
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
