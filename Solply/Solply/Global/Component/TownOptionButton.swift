//
//  TownOptionButton.swift
//  Solply
//
//  Created by 선영주 on 7/8/25.
//

import SwiftUI

struct TownOptionButton: View {

    // MARK: - Properties
    
    private let type: TownOptionButtonType
    private let isSelected: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        type: TownOptionButtonType,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.type = type
        self.isSelected = isSelected
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

    private var content: some View {
        VStack(alignment: .leading, spacing: 10.adjustedWidth) {
            if let title = type.title {
                Text(title)
                    .applySolplyFont(.button_16_m)
                    .foregroundColor(.gray900)
            } else {
                Image(.plusIcon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray400)
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
            }
        }
        .frame(width: 100.adjustedWidth, height: 100.adjustedHeight)
        .background(type.backgroundColor(isSelected: isSelected))
        .capsuleClipped()
        .overlay(
            Circle()
                .stroke(type.borderColor(isSelected: isSelected), lineWidth: 1)
        )
    }
}

// MARK: - Type

extension TownOptionButton {
    enum TownOptionButtonType {
            case named(String)
            case add

        var title: String? {
            switch self {
            case .named(let name):
                return name
            case .add:
                return nil
            }
        }

        func backgroundColor(isSelected: Bool) -> Color {
            switch self {
            case .named:
                return isSelected ? .gray100 : .red100
            case .add:
                return .gray200
            }
        }

        func borderColor(isSelected: Bool) -> Color {
            switch self {
            case .named:
                return isSelected ? .gray300 : .red300
            case .add:
                return .gray200
            }
        }
    }
}
