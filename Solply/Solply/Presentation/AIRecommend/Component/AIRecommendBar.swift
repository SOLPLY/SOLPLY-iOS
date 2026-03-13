//
//  AIRecommendBar.swift
//  Solply
//
//  Created by seozero on 3/13/26.
//

import SwiftUI

struct AIRecommendBar: View {
    
    // MARK: - Properties
    
    private let selected: SolplyContentType
    
    // MARK: - Initializer
    
    init(
        selected: SolplyContentType
    ) {
        self.selected = selected
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(SolplyContentType.allCases, id: \.self) { category in
                Button {
                    
                } label: {
                    Text(category.title)
                        .foregroundColor(selected == category ? .coreBlack : .gray800)
                        .applySolplyFont(selected == category ? .head_15_sb : .head_15_m)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48.adjustedHeight)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .overlay(alignment: .bottom) {
            Capsule()
                .fill(.gray800)
                .frame(width: 181.adjustedWidth, height: 3.adjustedHeight)
                .frame(
                    maxWidth: .infinity,
                    alignment: selected == .place ? .leading : .trailing
                )
                .animation(.easeInOut(duration: 0.3), value: selected)
        }
        .background(.coreWhite)
    }
}
