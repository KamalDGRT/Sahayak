//
//  MaterialTextField.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//
// Reference github.com/norrisboat/MaterialTextFieldSwiftUI

import SwiftUI

/// A view mimicing the material text view provided by Google with various customizations
public struct MaterialTextField: View {
    
    @Binding private var content: String
    @Binding private var isFocused: Bool
    @State private var isFilled: Bool = false
    @Binding private var placeHolder: PlaceHolder
    @ObservedObject private var notifier = MaterialTextFieldNotifier()
    
    var style: MaterialTextFieldStyle
    
    /// Show a Material Text Field with default parameters
    /// - Parameters:
    ///   - content: Text content
    ///   - placeHolder: Hint to give the user an idea of what to input
    ///   - isValid: A Binding to indicate if the input is valid
    ///   - style: The style of the text field. Default is normal
    public init(
        _ content: Binding<String>,
        placeHolder: Binding<PlaceHolder>,
        isFocused: Binding<Bool>,
        style: MaterialTextFieldStyle = .outline
    ) {
        self._content = content
        self._isFocused = isFocused
        self._placeHolder = placeHolder
        self.style = style
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                background()
                
                HStack {
                    
                    notifier.leftView
                    
                    contentView()
                    
                    notifier.rightView
                }
                .padding(.horizontal, 16.0)
            }
            
            bottomLine()
            
            HStack {
                if notifier.helperText.isNotBlank {
                    helperTextView()
                } else {
                    if notifier.errorText.isVisible {
                        errorView()
                    }
                }
                if notifier.showCharacterCounter {
                    characterCounterTextView()
                }
            }
        }
        .onAppear {
            isFilled = content.count > 0
        }
    }
    
    func clear() {
        self.content = ""
    }
}

// MARK: Private Extensions
private extension MaterialTextField {
    //MARK: Content View
    @ViewBuilder
    func contentView() -> some View {
        let isFilledOrFocused = isFilled || isFocused
        let isOutlined = style == .outline
        
        ZStack {
            
            if placeHolder.isVisible {
                placeHolderText()
            }
            
            if notifier.isSecure {
                passwordInput()
            } else {
                textInput()
            }
        }
        .offset(x: 0, y: isFilledOrFocused && isOutlined ? 6 : 0)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
    }
    
    @ViewBuilder
    func placeHolderText() -> some View {
        let isFilledOrFocused = isFilled || isFocused
        let isFloating = style == .floating
        let isOutlined = style == .outline
        
        Text(placeHolder.text)
            .font(.custom(
                notifier.placeholderFont.fontName,
                size: isFilledOrFocused ? 12.0 : notifier.placeholderFont.fontSize
            ))
            .foregroundColor(decidePlaceHolderTextColor())
            .padding(.horizontal, isFilledOrFocused && isFloating ? 5 : 0)
            .background(
                Rectangle()
                    .foregroundColor(notifier.placeholderFont.backgroundColor)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(
                x: isFilledOrFocused && isFloating ? -5 : 0,
                y: isFilledOrFocused ? isFloating ? -27 : isOutlined ? -18 : -12  : 0
            )
        
    }
    
    func decidePlaceHolderTextColor() -> Color {
        var color = notifier.placeholderFont.fontColor
        if notifier.isDisabled {
            color = Color.gray.opacity(0.5)
        } else if notifier.errorText.isFailure {
            color = notifier.errorTextFont.fontColor
        }
        
        return color
    }
    
    
    @ViewBuilder
    func passwordInput() -> some View {
        SecureField("", text: $content.animation().limit(notifier.maxCharacters))
            .font(.custom(notifier.textFont.fontName, size: notifier.textFont.fontSize))
            .foregroundColor(notifier.textFont.fontColor)
            .accentColor(notifier.accentColor)
            .disabled(notifier.isDisabled)
            .keyboardType(notifier.keyboardType)
            .submitLabel(notifier.submitLabel)
            .onChange(of: content) {
                if(content == "") {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isFilled = false
                    }
                } else {
                    withAnimation(.easeIn(duration: 0.15)) {
                        isFilled = true
                    }
                }
            }
    }
    
    @ViewBuilder
    func textInput() -> some View {
        TextField("", text: $content.animation().limit(notifier.maxCharacters))
            .font(.custom(notifier.textFont.fontName, size: notifier.textFont.fontSize))
            .foregroundColor(notifier.textFont.fontColor)
            .accentColor(notifier.accentColor)
            .disabled(notifier.isDisabled)
            .keyboardType(notifier.keyboardType)
            .submitLabel(notifier.submitLabel)
            .onChange(of: content) {
                if(content == "") {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isFilled = false
                    }
                } else {
                    withAnimation(.easeIn(duration: 0.15)) {
                        isFilled = true
                    }
                }
            }
    }
    
    //MARK: Bottom Line
    @ViewBuilder
    func bottomLine() -> some View {
        switch style {
        case .normal:
            Rectangle()
                .frame(height: isFocused ? 2 : 0.5)
                .cornerRadius(2)
                .padding(.top, 5)
                .foregroundColor(isFocused ? notifier.borderColor.focused : notifier.borderColor.normal)
        case .outline, .floating:
            EmptyView()
        }
    }
    
    //MARK: Error View
    func errorView() -> some View {
        // TODO: add with model
        Text(notifier.errorText.text)
            .foregroundColor(notifier.errorTextFont.fontColor)
            .font(.custom(notifier.errorTextFont.fontName, size: notifier.errorTextFont.fontSize))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 5)
    }
    
    //MARK: Helper Text View
    func helperTextView() -> some View {
        Text(notifier.helperText)
            .foregroundColor(notifier.helperTextFont.fontColor)
            .font(.custom(notifier.helperTextFont.fontName, size: notifier.helperTextFont.fontSize))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
    }
    
    //MARK: Character Count View
    func characterCounterTextView() -> some View {
        Text(content.isEmpty ? "" : String.init(format: "%d/%d", content.count, notifier.maxCharacters))
            .foregroundColor(.gray)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.leading, 8)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 8)
    }
    
    //MARK: Background View
    @ViewBuilder
    func background() -> some View {
        switch style {
        case .normal:
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 5)
                .fill(.gray.opacity(0.1))
                .frame(height: 56)
                .padding(.bottom, -6)
                .padding(.top, -6)
            
        case .floating, .outline:
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(lineWidth: isFocused ? 2.0 : 1.0)
                .foregroundColor(decideBorder())
                .frame(height: 56)
        }
    }
    
    func decideBorder() -> Color {
        var color = notifier.borderColor.normal
        
        if notifier.isDisabled {
            color = notifier.borderColor.disabled
        } else if isFocused {
            color = notifier.borderColor.focused
        } else if notifier.errorText.isVisible {
            color = notifier.errorText.isFailure ? notifier.borderColor.failure : notifier.borderColor.success
        }
        
        return color
    }
}

//MARK: Public Extensions
public extension MaterialTextField {
    /// Sets the color to show when the text field is active and the cursor color
    /// - Parameter color: Accent color
    /// - Returns: MaterialTextField
    func accentColor(_ color: Color) -> Self {
        notifier.accentColor = color
        return self
    }
    
    /// Sets the condition to show the error view
    /// - Parameter show: Boolean state to enable or disable showing an error
    /// - Returns: MaterialTextField
    func showError(_ show: Bool) -> Self {
        notifier.errorText.isVisible = show
        return self
    }
    
    /// Sets the helper text
    /// - Parameter text: The helper text
    /// - Returns: MaterialTextField
    func helperText(_ text: String) -> Self {
        notifier.helperText = text
        return self
    }
    
    /// Sets if the MaterialTextField is secure
    /// - Parameter isSecure: Boolean state to enable or disable secure text input
    /// - Returns: MaterialTextField
    func isSecure(_ isSecure: Bool) -> Self {
        notifier.isSecure = isSecure
        return self
    }
    
    /// Sets if the MaterialTextField is disabled
    /// - Parameter isDisabled: Boolean state to enable or disable MaterialTextField
    /// - Returns: MaterialTextField
    func isDisabled(_ isDisabled: Bool) -> Self {
        notifier.isDisabled = isDisabled
        return self
    }
    
    
    /// Sets the maximum character count to be accepted
    /// - Parameter max: The maximum character count
    /// - Returns: MaterialTextField
    func maxCharacterCount(_ max: Int) -> Self {
        notifier.maxCharacters = max
        return self
    }
    
    /// Sets if the character counter view should show or not
    /// - Parameter show: Boolean state to show character count or not
    /// - Returns: MaterialTextField
    func showCharacterCounter(_ show: Bool) -> Self {
        notifier.showCharacterCounter = show
        return self
    }
    
    /// Sets the left view
    /// - Parameter view:  A view that will be shown on the leading side of the MaterialTextField
    /// - Returns: MaterialTextField
    func leftView<LeftView: View>(@ViewBuilder _ view: @escaping () -> LeftView) -> Self {
        notifier.leftView = AnyView(view())
        return self
    }
    
    /// Sets the right view
    /// - Parameter view:  A view that will be shown on the trailing side of the MaterialTextField
    /// - Returns: MaterialTextField
    func rightView<RightView: View>(@ViewBuilder _ view: @escaping () -> RightView) -> Self {
        notifier.rightView = AnyView(view())
        return self
    }
    
    
    func onSubmit(_ onSubmit: @escaping () -> Void) {
        notifier.onSubmit = onSubmit
    }
    
    func placeHolderFont(_ fontName: String, _ size: CGFloat, _ color: Color) -> Self {
        notifier.placeholderFont.fontName = fontName
        notifier.placeholderFont.fontSize = size
        notifier.placeholderFont.fontColor = color
        return self
    }
    
    func textFont(_ fontName: String, _ size: CGFloat, _ color: Color) -> Self {
        notifier.textFont.fontName = fontName
        notifier.textFont.fontSize = size
        notifier.textFont.fontColor = color
        return self
    }
    
    func errorTextFont(_ fontName: String, _ size: CGFloat, _ color: Color) -> Self {
        notifier.errorTextFont.fontName = fontName
        notifier.errorTextFont.fontSize = size
        notifier.errorTextFont.fontColor = color
        return self
    }
    
    func helperTextFont(_ fontName: String, _ size: CGFloat, _ color: Color) -> Self {
        notifier.helperTextFont.fontName = fontName
        notifier.helperTextFont.fontSize = size
        notifier.helperTextFont.fontColor = color
        return self
    }
    
    /// Content type of the input. It helps determine which keyboard type to show
    /// - Parameter type: type of the keyboard
    /// - Returns: MaterialTextField
    func keyboardType(_ type: UIKeyboardType) -> Self {
        notifier.keyboardType = type
        return self
    }
    
    
    func submitLabel(_ label: SubmitLabel) -> Self {
        notifier.submitLabel = label
        return self
    }
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        notifier.cornerRadius = radius
        return self
    }
    
    func errorText(isVisible: Bool, isFailure: Bool, description: String) -> Self {
        notifier.errorText.isVisible = isVisible
        notifier.errorText.isFailure = isFailure
        notifier.errorText.text = description
        return self
    }
    
    func borderColor(
        normal: Color = Color.gray,
        disabled: Color  = Color.gray.opacity(0.5),
        focused: Color  = Color.blue,
        success: Color  = Color.green,
        failure: Color  = Color.red
    ) -> Self {
        notifier.borderColor.normal = normal
        notifier.borderColor.disabled = disabled
        notifier.borderColor.focused = focused
        notifier.borderColor.success = success
        notifier.borderColor.failure = failure
        
        return self
    }
}
