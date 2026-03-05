//
//  MoreOptionChip.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct SubTagChip: View {
    
    // MARK: - Properties
    
    private let title: String
    private var isSelected: Bool
    
    // MARK: - Initializer
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
    // MARK: - Body
    
    var body: some View {
        Text(title)
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.vertical, 8.adjustedHeight)
            .applySolplyFont(.body_16_m)
            .foregroundStyle(isSelected ? .coreWhite : .gray900)
            .background(isSelected ? .gray900 : .coreWhite)
            .capsuleClipped()
            .addBorder(
                .capsule,
                borderColor: isSelected ? .clear : .gray300,
                borderWidth: 0.75
            )
            .contentShape(Capsule())
    }
}
