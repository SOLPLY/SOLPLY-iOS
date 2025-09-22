//
//  JGDTownRow.swift
//  Solply
//
//  Created by seozero on 9/22/25.
//

import SwiftUI

struct JGDTownRow: View {
    @Binding var selectedTown: String?
    let town: String

    var body: some View {
        Button {
            self.selectedTown = town
        } label: {
            ZStack(alignment: .bottom) {
                HStack(alignment: .center, spacing: 0) {
                    Text(town)
                        .applySolplyFont(selectedTown == nil ? .body_16_r : selectedTown == town ? .body_16_m : .body_16_r)
                        .foregroundStyle(selectedTown == nil ? .coreBlack : selectedTown == town ? .coreBlack : .gray600)
                        .frame(height: 46.adjustedHeight)
                    
                    Spacer()
                    
                    if selectedTown == town {
                        Image(.selectIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            .opacity(selectedTown == town ? 1.0 : 0.0)
                            .padding(.trailing, 2.adjustedWidth)
                    }
                }
                .padding(.horizontal, 16)
                
                Rectangle()
                    .foregroundStyle(.gray200)
                    .frame(height: 1.adjustedHeight)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
