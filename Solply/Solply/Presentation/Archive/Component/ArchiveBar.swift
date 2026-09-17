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
        HStack(spacing: 8.adjustedWidth) {
            ForEach(SolplyContentType.allCases, id: \.self) { category in
                Button {
                    action?(category)
                } label: {
                    Text(category.title)
                        .applySolplyFont(.body_16_m)
                        .foregroundColor(selected == category ? .coreWhite : .gray900)
                        .frame(width: 60.adjustedWidth, height: 40.adjustedHeight)
                        .background(selected == category ? .gray900 : .gray200)
                        .capsuleClipped()
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.leading, 16.adjustedWidth)
        .background(.gray100)
    }
}
