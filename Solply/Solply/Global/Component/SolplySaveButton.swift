//
//  SolplySaveButton.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import SwiftUI

struct SolplySaveButton: View {
    
    // MARK: - Properties
    
    private let contentType: SolplyContentType
    private var isEnabled: Bool
    private var isSelected: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        contentType: SolplyContentType,
        isEnabled: Bool,
        isSelected: Bool,
        action: (() -> Void)? = nil
    ) {
        self.contentType = contentType
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Text(isSelected ? "저장된 \(contentType.title)" : "\(contentType.title) 저장")
                    .applySolplyFont(.button_14_m)
                    .foregroundStyle(isEnabled ? (isSelected ? .red500: .purple600) : .gray400)
                
                Image(.logoVector)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(isEnabled ? (isSelected ? .red500 : .purple600) : .gray400)
            }
            .frame(
                height: 47.adjustedHeight,
                alignment: .trailing
            )
            .padding(.trailing, 8.adjustedWidth)
            .padding(.leading, 16.adjustedWidth)
            .background(isEnabled ? (isSelected ? .red100 : .coreWhite) : .coreWhite)
            .capsuleClipped()
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .allowsHitTesting(isEnabled)
        .buttonStyle(.plain)
    }
}
