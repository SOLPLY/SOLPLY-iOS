//
//  AIRecommendBar.swift
//  Solply
//
//  Created by seozero on 3/13/26.
//

import SwiftUI

struct AIRecommendBar: View {
    
    // MARK: - Properties
    
    private let selectedCategory: SolplyContentType
    private let action: ((SolplyContentType) -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedCategory: SolplyContentType,
        action: ((SolplyContentType) -> Void)? = nil
    ) {
        self.selectedCategory = selectedCategory
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(SolplyContentType.allCases, id: \.self) { category in
                Button {
                    action?(category)
                } label: {
                    Text(category.title)
                        .foregroundColor(selectedCategory == category ? .coreBlack : .gray800)
                        .applySolplyFont(selectedCategory == category ? .head_15_sb : .head_15_m)
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
                    alignment: selectedCategory == .place ? .leading : .trailing
                )
                .animation(.easeInOut(duration: 0.3), value: selectedCategory)
        }
        .background(.coreWhite)
    }
}
