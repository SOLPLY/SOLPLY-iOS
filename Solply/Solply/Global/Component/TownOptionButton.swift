//
//  TownOptionButton.swift
//  Solply
//
//  Created by 선영주 on 7/8/25.
//

import SwiftUI

struct TownOptionButton: View {

    // MARK: - Properties
    
    private let type: TownOptionType
    private let isSelected: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        type: TownOptionType,
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
        .addBorder(.circle, borderColor: type.borderColor(isSelected: isSelected), borderWidth: 1)
    }
}
