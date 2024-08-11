//
//  Binding.swift
//  Sahayak
//


import SwiftUI

// MARK: Binding <String> Extension
public extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
