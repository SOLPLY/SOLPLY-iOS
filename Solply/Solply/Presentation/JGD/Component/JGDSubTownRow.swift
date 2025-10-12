//
//  JGDSubTownRow.swift
//  Solply
//
//  Created by seozero on 9/22/25.
//

import SwiftUI

struct JGDSubTownRow: View {

    // MARK: - Props
    
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    // MARK: - Body
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    Text(title)
                        .applySolplyFont(isSelected ? .body_16_m : .body_16_r)
                        .foregroundStyle(isSelected ? .coreBlack : .gray600)
                        .frame(height: 46.adjustedHeight)

                    Spacer()

                    if isSelected {
                        Image(.selectIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            .padding(.trailing, 2.adjustedWidth)
                    }
                }
                .padding(.horizontal, 16.adjustedWidth)

                Rectangle()
                    .foregroundStyle(.gray200)
                    .frame(height: 1.adjustedHeight)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
