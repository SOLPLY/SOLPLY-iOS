//
//  ArchiveBar.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import SwiftUI

struct ArchiveBar: View {
    
    // MARK: - Properties
    
    private let action: ((SolplyContentType) -> Void)?
    private let selected: SolplyContentType
    
    // MARK: - Initializer
    
    init(
        selected: SolplyContentType,
        action: ((SolplyContentType) -> Void)? = nil
    ) {
        self.selected = selected
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(SolplyContentType.allCases, id: \.self) { category in
                Button {
                    action?(category)
                } label: {
                    VStack(spacing: 0) {
                        Text(category.title)
                            .foregroundColor(selected == category ? .coreBlack : .gray800)
                            .applySolplyFont(.head_15_sb)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48.adjustedHeight)
                            .contentShape(Rectangle())
                    }
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
