//
//  MaterialTextFieldUtils.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//
// Reference github.com/norrisboat/MaterialTextFieldSwiftUI

import SwiftUI
import Combine

public enum MaterialTextFieldStyle {
    case normal
    case floating
    case outline
}

public struct PlaceHolder {
    var text: String = ""
    var textSize: CGFloat = 16.0
    var padding: CGFloat = 0.0
    var backgroundColor: Color = .clear
    var offset: CGFloat = 0.0
    var isVisible = true
}

public struct ErrorLabel {
    var isVisible = false
    var isFailure = false
    var description = ""
}

public struct MaterialFont {
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var backgroundColor: Color
    
    init(
        _ fontName: String = "",
        _ fontSize: CGFloat = 16.0,
        _ fontColor: Color = .black,
        _ backgroundColor: Color = .white
    ) {
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.backgroundColor = backgroundColor
    }
}

public struct MaterialBorderColor {
    var normal = Color.gray
    var disabled = Color.gray.opacity(0.5)
    var focused = Color.blue
    var success = Color.green
    var failure = Color.red
}

class MaterialTextFieldNotifier: ObservableObject {
    
    @Published var leftView: AnyView?
    @Published var rightView: AnyView?
    
    @Published var isSecure: Bool = false
    @Published var keyboardType: UIKeyboardType = .default
    @Published var accentColor: Color = .blue
    @Published var submitLabel: SubmitLabel = .return
    @Published var cornerRadius: CGFloat = 5.0
    @Published var isDisabled: Bool = false
    @Published var maxCharacters: Int = .max
    @Published var showCharacterCounter: Bool = false
    @Published var helperText: String = ""
    @Published var errorText = ErrorLabel()
    @Published var borderColor = MaterialBorderColor()
    @Published var placeholderFont = MaterialFont()
    @Published var textFont = MaterialFont()
    @Published var errorTextFont = MaterialFont()
    @Published var helperTextFont = MaterialFont()
    
    @Published var onSubmit: () -> Void = {}
}
