//
//  TextFieldInput.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import Foundation

public struct TextFieldInput {
    public var text: String
    public var placeHolder: PlaceHolder
    public var isFocused: Bool
    public var errorText: ErrorLabel
    
    public init(
        text: String,
        placeHolder: PlaceHolder,
        isFocused: Bool,
        errorText: ErrorLabel
    ) {
        self.text = text
        self.isFocused = isFocused
        self.placeHolder = placeHolder
        self.errorText = errorText
    }
}
