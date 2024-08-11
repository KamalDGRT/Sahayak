//
//  ToggleStyles.swift
//  Sahayak
//

import SwiftUI

public struct CheckmarkToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    
    public init(_ onColor: Color = Color.green, _ offColor: Color = Color.gray) {
        self.onColor = onColor
        self.offColor = offColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            Rectangle()
                .foregroundColor(configuration.isOn ? onColor : offColor)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    circle(configuration.$isOn)
                )
                .cornerRadius(25)
        }
    }
    
    func circle(_ isOn: Binding<Bool>) -> some View {
        Circle()
            .foregroundColor(.white)
            .padding(.all, 3)
            .overlay(
                Image(systemName: isOn.wrappedValue ? "checkmark" : "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(Font.title.weight(.black))
                    .frame(width: 8.0, height: 8.0, alignment: .center)
                    .foregroundColor(isOn.wrappedValue ? .green : .gray)
            )
            .offset(x: isOn.wrappedValue ? 11 : -11, y: 0)
    }
}

public struct CustomToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    
    public init(_ onColor: Color = Color.green, _ offColor: Color = Color.gray) {
        self.onColor = onColor
        self.offColor = offColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 16.0, style: .circular)
                .strokeBorder(.clear, lineWidth: 1.0)
                .background(
                    RoundedRectangle(cornerRadius: 16.0, style: .circular)
                        .fill(configuration.isOn ? onColor : offColor)
                )
                .frame(width: 50, height: 30)
                .overlay(
                    circle(configuration.$isOn)
                )
        }
    }
    
    func circle(_ isOn: Binding<Bool>) -> some View {
        Circle()
            .fill(isOn.wrappedValue ? .white : .white.opacity(0.7))
            .shadow(radius: 1, x: 0, y: 1)
            .padding(1.5)
            .offset(x: isOn.wrappedValue ? 10: -10)
    }
}
