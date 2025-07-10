//
//  PersonaOptionButton.swift
//  Solply
//
//  Created by 선영주 on 7/10/25.
//

import SwiftUI

struct PersonaOptionButton: View {

    // MARK: - Properties

    private let title: String
    private let isSelected: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer

    init(
        title: String,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
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

    // MARK: - Subview

    private var content: some View {
        HStack {
            Text(title)
                .applySolplyFont(.button_16_m)
                .foregroundColor(.gray900)
            
            Spacer()
            
            if isSelected {
                Image(.selectIcon)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
        .frame(height: 52.adjustedHeight)
        .background(
            Rectangle()
                .fill(isSelected ? .red100 : .gray100)
        .addBorder(.roundedRectangle(cornerRaius: 20),
                borderColor: isSelected ? .red300 : .gray300,
                    borderWidth: 1))
    }
}
