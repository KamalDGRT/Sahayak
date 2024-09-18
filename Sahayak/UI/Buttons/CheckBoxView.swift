//
// CheckBoxView.swift
// Sahayak
//

import SwiftUI

public enum CheckBoxImageType {
    case system
    case custom
}

public struct CheckBoxView: View {
    let isSelected: Binding<Bool>
    let imageType: CheckBoxImageType
    let selectedImage: String
    let unselectedImage: String
    let width: CGFloat
    let height: CGFloat
    let fillColor: Color
    let borderColor: Color
    let accessibilityIdentifier: String?
    let onSelect: EmptyClosure
    
    public init(
        isSelected: Binding<Bool>,
        imageType: CheckBoxImageType = .system,
        selectedImage: String = "checkmark.square.fill",
        unselectedImage: String = "square",
        width: CGFloat = 30,
        height: CGFloat = 30,
        fillColor: Color = .white,
        borderColor: Color = .black,
        accessibilityIdentifier: String? = nil,
        onSelect: @escaping EmptyClosure
    ) {
        self.isSelected = isSelected
        self.imageType = imageType
        self.selectedImage = selectedImage
        self.unselectedImage = unselectedImage
        self.width = width
        self.height = height
        self.fillColor = fillColor
        self.borderColor = borderColor
        self.accessibilityIdentifier = accessibilityIdentifier
        self.onSelect = onSelect
    }
    
    /// Body of the checkbox view
    public var body: some View {
        Button(action: onSelect) {
            checkBoxImage
                .frame(width: width, height: height)
        }
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
    }
}

private extension CheckBoxView {
    var checkBoxImage: some View {
        switch imageType {
        case .system: AnyView(systemImage)
        case .custom: shouldShowSystemImage ? AnyView(systemImage) : AnyView(customImage)
        }
    }
    
    var shouldShowSystemImage: Bool {
        selectedImage.imageIsAbsent || unselectedImage.imageIsAbsent
    }
    
    var systemImage: some View {
        Image(systemName: isSelected.wrappedValue ? selectedImage : unselectedImage)
            .resizable()
            .tint(borderColor)
            .background(fillColor)
            .clipShape(RoundedCornersShape(.allCorners, 4))
    }
    
    var customImage: some View {
        Image(isSelected.wrappedValue ? selectedImage : unselectedImage)
    }
}

#Preview {
    VStack(spacing: 10) {
        CheckBoxView(isSelected: .constant(true)) {}
        CheckBoxView(isSelected: .constant(false)) {}
    }
}
