//
//  MaterialButton.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import SwiftUI

struct MaterialButton: View {
    var title: String
    var titleFont = MaterialFont()
    var backgroundColor: Color
    var height = 45.0
    var cornerRadius = 10.0
    var isDisabled = false
    var accessibilityIdentifier: String?
    var ctaAction: (() -> Void)
    
    var body: some View {
        Button(action: {
            ctaAction()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius, style: RoundedCornerStyle.circular)
                    .fill(backgroundColor)
                    .frame(height: height, alignment: .center)
                    .opacity(isDisabled ? 0.3 : 1.0)
                
                Text(title)
                    .font(.custom(titleFont.fontName, size: titleFont.fontSize))
                    .foregroundColor(titleFont.fontColor)
            }
        }
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
        .disabled(isDisabled)
    }
}

#Preview {
    MaterialButton(
        title: "Click Me!",
        backgroundColor: .red,
        height: 48.0,
        cornerRadius: 10.0,
        accessibilityIdentifier: "",
        ctaAction: {}
    )
    .padding(10)
}
