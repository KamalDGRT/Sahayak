//
//  Shapes.swift
//  Sahayak
//

import SwiftUI

public struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    public init(_ corners: UIRectCorner, _ radius: CGFloat) {
        self.corners = corners
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
