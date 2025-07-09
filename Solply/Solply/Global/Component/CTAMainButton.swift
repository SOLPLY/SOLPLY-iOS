//
//  CTAMainButton.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct CTAMainButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let type: CTAMainButtonType
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        type: CTAMainButtonType = .enabled,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.type  = type
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let action = action {
                Button {
                    if type == .enabled { action() }
                } label: {
                    content
                }
                .disabled(type == .disabled)
            } else {
                content
            }
        }
    }
    
    // MARK: - Content View
    
    private var content: some View {
        Text(title)
            .applySolplyFont(.button_16_m)
            .foregroundStyle(type.foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: 64.adjustedHeight)
            .background(
                Capsule().fill(type.backgroundColor)
            )
            .animation(.easeInOut(duration: 0.2), value: type)
    }
}

// MARK: - Type

extension CTAMainButton {
    enum CTAMainButtonType {
        case enabled
        case disabled
        
        var backgroundColor: Color {
            switch self {
            case .enabled:  return .gray900
            case .disabled: return .gray300
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .enabled:  return .coreWhite
            case .disabled: return .gray800
            }
        }
    }
}
