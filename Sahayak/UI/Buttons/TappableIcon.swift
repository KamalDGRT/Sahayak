//
//  TappableIcon.swift
//  Sahayak
//

import SwiftUI

public struct TappableIcon: View {
    var iconName: String
    var iconWidth: CGFloat
    var iconHeight: CGFloat
    var isTappable: Bool
    var accessibilityIdentifier: String?
    var clickAction: (() -> Void)? /// use closure for callback
    
    public var body: some View {
        Button(action: {
            clickAction?()
        }) {
            Image(iconName)
                .fixedSize()
                .frame(width: iconWidth, height: iconHeight)
        }
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
        .disabled(!isTappable)
    }
    
    public init(
        _ iconName: String,
        _ iconWidth: CGFloat,
        _ iconHeight: CGFloat,_
        isTappable: Bool = true,
        accessibilityIdentifier: String? = nil,
        clickAction: (() -> Void)? = nil
    ) {
        self.iconName = iconName
        self.iconWidth = iconWidth
        self.iconHeight = iconHeight
        self.isTappable = isTappable
        self.accessibilityIdentifier = accessibilityIdentifier
        self.clickAction = clickAction
    }
}
