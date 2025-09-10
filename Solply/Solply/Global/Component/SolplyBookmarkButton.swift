//
//  SolplyBookmarkButton.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import SwiftUI

struct SolplyBookmarkButton: View {
    
    // MARK: - Properties
    
    private var isEnabled: Bool
    private var isBookmarked: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        isEnabled: Bool,
        isBookmarked: Bool,
        action: (() -> Void)? = nil
    ) {
        self.isEnabled = isEnabled
        self.isBookmarked = isBookmarked
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(isEnabled ? (isBookmarked ? .red100 : .coreWhite) : .coreWhite)
                    .frame(width: 48.adjustedWidth, height: 48.adjustedHeight)
                
                Image(isBookmarked ? .bookmarkFilledIcon : .bookmarkIcon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28.adjustedWidth, height: 28.adjustedHeight)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(isEnabled ? (isBookmarked ? .red500 : .purple600) : .gray400)
            }
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
            .animation(.easeInOut(duration: 0.2), value: isBookmarked)
        }
        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
        .allowsHitTesting(isEnabled)
        .buttonStyle(.plain)
    }
}
