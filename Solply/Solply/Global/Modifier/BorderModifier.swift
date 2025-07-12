//
//  BorderModifier.swift
//  Solply
//
//  Created by 김승원 on 7/8/25.
//

import SwiftUI

struct BorderModifier: ViewModifier {
    private let borderType: BorderType
    private let borderColor: Color
    private let borderWidth: CGFloat
    
    init(borderType: BorderType, borderColor: Color, borderWidth: CGFloat = 1) {
        self.borderType = borderType
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    func body(content: Content) -> some View {
        switch borderType {
        case .roundedRectangle(let cornerRaius):
            content.overlay(
                RoundedRectangle(cornerRadius: cornerRaius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            
        case .capsule:
            content.overlay(
                Capsule()
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            
        case .circle:
            content.overlay(
                Circle()
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
    }
}

extension BorderModifier {
    enum BorderType {
        case roundedRectangle(cornerRadius: CGFloat)
        case capsule
        case circle
    }
}

extension View {
    func addBorder(
        _ borderType: BorderModifier.BorderType,
        borderColor: Color,
        borderWidth: CGFloat
    ) -> some View {
        self.modifier(
            BorderModifier(
                borderType: borderType,
                borderColor: borderColor,
                borderWidth: borderWidth
            )
        )
    }
}
