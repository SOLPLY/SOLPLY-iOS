//
//  TownOptionButton.swift
//  Solply
//
//  Created by 선영주 on 7/8/25.
//

import SwiftUI

struct TownOptionButton: View {

    // MARK: - Properties
    
    private let title: String?
    private let isSelected: Bool
    private let isPlusButton: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        title: String?,
        isSelected: Bool = false,
        isPlusButton: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isPlusButton = isPlusButton
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
            if let title = title {
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
        .background(backgroundColor)
        .capsuleClipped()
        .addBorder(.circle, borderColor: borderColor, borderWidth: 1)
    }
    
    private var backgroundColor: Color {
        if isPlusButton {
            return .gray200
        }
        
        return isSelected ? .red100 : .gray100
    }

    private var borderColor: Color {
        if isPlusButton {
            return .gray200
        }
        
        return isSelected ? .red300 : .gray300
    }
}
