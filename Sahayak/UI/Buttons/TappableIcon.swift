//
//  TappableIcon.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import SwiftUI

struct TappableIcon: View {
    var iconName: String
    var iconWidth: CGFloat
    var iconHeight: CGFloat
    var isTappable: Bool = true
    var accessibilityIdentifier: String?
    var clickAction: (() -> Void)? /// use closure for callback
    
    var body: some View {
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
}
