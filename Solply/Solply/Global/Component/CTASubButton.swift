//
//  CTASubButton.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct CTASubButton: View {

    // MARK: - Properties
    
    private let title: String
    private let type: CTASubButtonType
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        title: String,
        type: CTASubButtonType = .white,
        action: (() -> Void)? = nil
    ) {
        self.title  = title
        self.type   = type
        self.action = action
    }

    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            content
        }
        .buttonStyle(.plain)
    }

    // MARK: - Content View
    
    private var content: some View {
        Text(title)
            .applySolplyFont(.button_16_m)
            .foregroundStyle(type.foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: 64.adjustedHeight)
            .background(
                Capsule()
                    .fill(type.backgroundColor)
            )
            .animation(.easeInOut(duration: 0.2), value: type)
    }
}

// MARK: - Type

extension CTASubButton {
    enum CTASubButtonType {
        case white
        case clear

        var backgroundColor: Color {
            switch self {
            case .white: return .coreWhite
            case .clear: return .clear
            }
        }

        var foregroundColor: Color { .gray900 }
    }
}
