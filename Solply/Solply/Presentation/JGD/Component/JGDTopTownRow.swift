//
//  JGDTopTownRow.swift
//  Solply
//
//  Created by seozero on 9/20/25.
//

import SwiftUI

struct JGDTopTownRow: View {
    
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .applySolplyFont(.body_16_m)
                .foregroundStyle(isSelected ? .coreBlack : .gray600)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 46.adjustedHeight)
                .padding(.horizontal, 16.adjustedWidth)
                .background(isSelected ? .coreWhite : .gray100)
                .overlay(Rectangle().frame(height: 1.adjustedHeight)
                    .foregroundStyle(.gray200), alignment: .bottom)
        }
        .buttonStyle(.plain)
    }
}
