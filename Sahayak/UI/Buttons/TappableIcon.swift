//
//  TappableIcon.swift
//  Sahayak
//

import SwiftUI

public struct TappableIcon: View {
    private let iconName: String
    private let iconWidth: CGFloat
    private let iconHeight: CGFloat
    private let isTappable: Bool
    private let accessibilityIdentifier: String?
    private let clickAction: EmptyClosure? /// use closure for callback
    
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
        clickAction: EmptyClosure? = nil
    ) {
        self.iconName = iconName
        self.iconWidth = iconWidth
        self.iconHeight = iconHeight
        self.isTappable = isTappable
        self.accessibilityIdentifier = accessibilityIdentifier
        self.clickAction = clickAction
    }
}
