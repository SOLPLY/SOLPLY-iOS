//
//  MoreOptionButton.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct MoreOptionButton: View {
    
    private let title: String
    private let isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
    var body: some View {
        Button {
            
        } label: {
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
        }

    }
}

#Preview {
    MoreOptionButton(title: "콘센트 많음", isSelected: false)
}
