//
// Date.swift
// Sahayak
//

import Foundation

public extension Date {
    func isTokenExpired() -> Bool {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "IST")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        let currentDate = Date()
        let currentDateString = formatter.string(from: currentDate)
        let currentDateInIST = formatter.date(from: currentDateString) ?? currentDate
        
        let expirationDate = self
        let expirationDateString = formatter.string(from: expirationDate)
        let expirationDateInIST = formatter.date(from: expirationDateString) ?? currentDate

        return currentDateInIST >= expirationDateInIST
    }
    
    func isValidToken() -> Bool {
        !isTokenExpired()
    }
}
