//
//  TextFieldInput.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import Foundation

public struct TextFieldInput {
    var placeHolder: PlaceHolder
    var text: String
    var isFocused: Bool
    var errorText: ErrorLabel
    
    init(
        _ placeHolder: PlaceHolder = PlaceHolder(text: ""),
        _ text: String = "",
        _ isFocused: Bool = false,
        _ errorText: ErrorLabel = ErrorLabel()
    ) {
        self.text = text
        self.isFocused = isFocused
        self.placeHolder = placeHolder
        self.errorText = errorText
    }
}
