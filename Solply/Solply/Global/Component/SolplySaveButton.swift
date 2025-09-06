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
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(isEnabled ? (isSelected ? .red100 : .coreWhite) : .coreWhite)
                    .frame(width: 48.adjustedWidth, height: 48.adjustedHeight)
                
                Image(isSelected ? .bookmarkFilledIcon : .bookmarkIcon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28.adjustedWidth, height: 28.adjustedHeight)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(isEnabled ? (isSelected ? .red500 : .purple600) : .gray400)
            }
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
        .allowsHitTesting(isEnabled)
        .buttonStyle(.plain)
    }
}
