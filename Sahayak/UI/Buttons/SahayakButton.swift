//
//  SahayakButton.swift
//  Sahayak
//

import SwiftUI

class SahayakButtonNotifier: ObservableObject {
    var titleFont = SahayakFont("", 16.0, .black, .white)
    var backgroundColor: Color = .gray
    var height = 45.0
    var cornerRadius = 10.0
    var isDisabled = false
    var accessibilityIdentifier = ""
}

public struct SahayakButton: View {
    var title: String
    var ctaAction: EmptyClosure
    
    @ObservedObject private var notifier = SahayakButtonNotifier()
    
    public init(_ title: String, ctaAction: @escaping EmptyClosure) {
        self.title = title
        self.ctaAction = ctaAction
    }
    
    public var body: some View {
        Button(action: {
            ctaAction()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: notifier.cornerRadius, style: RoundedCornerStyle.circular)
                    .fill(notifier.backgroundColor)
                    .frame(height: notifier.height, alignment: .center)
                    .opacity(notifier.isDisabled ? 0.3 : 1.0)
                
                Text(title)
                    .font(.custom(notifier.titleFont.fontName, size: notifier.titleFont.fontSize))
                    .foregroundColor(notifier.titleFont.fontColor)
            }
        }
        .accessibilityIdentifier(notifier.accessibilityIdentifier)
        .disabled(notifier.isDisabled)
    }
}

// MARK: View Creators
public extension SahayakButton {
    func titleFont(_ font: SahayakFont) -> Self {
        self.notifier.titleFont = font
        return self
    }
    
    func backgroundColor(_ color: Color) -> Self {
        self.notifier.backgroundColor = color
        return self
    }
    
    func height(_ height: CGFloat) -> Self {
        self.notifier.height = height
        return self
    }
    
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.notifier.cornerRadius = cornerRadius
        return self
    }
    
    func isDisabled(_ shouldDisable: Bool) -> Self {
        self.notifier.isDisabled = shouldDisable
        return self
    }
    
    func accessibilityIdentifier(_ identifier: String) -> Self {
        self.notifier.accessibilityIdentifier = identifier
        return self
    }
}

#Preview {
    SahayakButton("Click Me!") {}
        .backgroundColor(.yellow)
        .cornerRadius(10)
        .height(50)
        .accessibilityIdentifier("Sahayak.Example.Button")
        .padding(20)
}
