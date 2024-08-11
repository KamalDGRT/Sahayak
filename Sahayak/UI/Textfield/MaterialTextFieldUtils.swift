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
    var text: String
    var textSize: CGFloat
    var padding: CGFloat
    var backgroundColor: Color
    var offset: CGFloat
    var isVisible: Bool
    
    public init(
        _ text: String = "",
        _ textSize: CGFloat = 16.0,
        _ padding: CGFloat = 0.0,
        _ backgroundColor: Color = .clear,
        _ offset: CGFloat = .zero,
        _ isVisible: Bool = true
    ) {
        self.text = text
        self.textSize = textSize
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.offset = offset
        self.isVisible = isVisible
    }
}

public struct ErrorLabel {
    var text: String
    var isVisible: Bool
    var isFailure: Bool
   
    public init(
        _ text: String,
        _ isVisible: Bool,
        _ isFailure: Bool
    ) {
        self.text = text
        self.isVisible = isVisible
        self.isFailure = isFailure
    }
}

public struct MaterialFont {
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var backgroundColor: Color
    
    public init(
        _ fontName: String,
        _ fontSize: CGFloat,
        _ fontColor: Color,
        _ backgroundColor: Color
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
    @Published var errorText = ErrorLabel("", false, false)
    @Published var borderColor = MaterialBorderColor()
    @Published var placeholderFont = MaterialFont("", 16.0, .black, .white)
    @Published var textFont = MaterialFont("", 16.0, .black, .white)
    @Published var errorTextFont = MaterialFont("", 16.0, .black, .white)
    @Published var helperTextFont = MaterialFont("", 16.0, .black, .white)
    
    @Published var onSubmit: () -> Void = {}
}
