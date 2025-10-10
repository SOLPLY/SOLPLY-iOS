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
            ZStack(alignment: .bottom) {
                Text(title)
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(isSelected ? .coreBlack : .gray600)
                    .frame(height: 46.adjustedHeight)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16.adjustedWidth)

                Rectangle()
                    .foregroundStyle(.gray200)
                    .frame(height: 1.adjustedHeight)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(isSelected ? .coreWhite : .gray100)
    }
}
