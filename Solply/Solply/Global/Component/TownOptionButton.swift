//
//  TownOptionButton.swift
//  Solply
//
//  Created by 선영주 on 7/8/25.
//

import SwiftUI

struct TownOptionButton: View {

    // MARK: - Properties
    
    let style: Style
    let isSelected: Bool
    let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        style: Style,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.style = style
        self.isSelected = isSelected
        self.action = action
    }

    // MARK: - Body
    
    var body: some View {
        if let action = action {
            Button(action: action) {
                content
            }
        } else {
            content
        }
    }

    private var content: some View {
        VStack(spacing: 10) {
            if let title = style.title {
                Text(title)
                    .applySolplyFont(.button_16_m)
                    .foregroundColor(.gray900)
            } else {
                Image("plus-icon")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 23)
        .frame(width: 100, height: 100)
        .background(style.backgroundColor(isSelected: isSelected))
        .cornerRadius(999)
        .overlay(
            RoundedRectangle(cornerRadius: 999)
                .stroke(style.borderColor(isSelected: isSelected), lineWidth: 1)
        )
    }
}

// MARK: - Style

extension TownOptionButton {
    enum Style {
        case mangwon
        case yeonhui
        case add

        var title: String? {
            switch self {
            case .mangwon: return "망원동"
            case .yeonhui: return "연희동"
            case .add:     return nil
            }
        }

        func backgroundColor(isSelected: Bool) -> Color {
            switch self {
            case .mangwon, .yeonhui:
                return isSelected ? Color("gray-100") : Color("red-100")
            case .add:
                return Color("gray-200")
            }
        }

        func borderColor(isSelected: Bool) -> Color {
            switch self {
            case .mangwon, .yeonhui:
                return isSelected ? Color("gray-300") : Color("red-300")
            case .add:
                return Color("gray-200")
            }
        }
    }
}
