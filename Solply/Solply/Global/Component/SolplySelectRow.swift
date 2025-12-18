//
//  SolplySelectRow.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import SwiftUI

struct SolplySelectRow: View {
    
    // MARK: - Properties
    
    private let title: String
    private let isSelected: Bool
    private let hideSeparator: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        isSelected: Bool = false,
        hideSeparator: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.isSelected = isSelected
        self.hideSeparator = hideSeparator
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Button {
                action?()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .applySolplyFont(isSelected ? .body_16_m : .body_16_r)
                        .foregroundStyle(.coreBlack)
                        .frame(height: 46.adjustedHeight)
                    
                    Spacer()
                    
                    Image(.selectIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjusted, height: 24.adjusted)
                        .opacity(isSelected ? 1.0 : 0.0)
                        .padding(.trailing, 2.adjustedWidth)
                }
                .background(.coreWhite)
            }
            .buttonStyle(.plain)
            
            Rectangle()
                .foregroundStyle(.gray200)
                .frame(height: hideSeparator ? 0 : 1.adjustedHeight)
        }
    }
}
