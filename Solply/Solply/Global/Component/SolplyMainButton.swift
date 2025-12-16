//
//  SolplyMainButton.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct SolplyMainButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let isEnabled: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        isEnabled: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.title   = title
        self.isEnabled = isEnabled
        self.action  = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            content
        }
        .buttonStyle(.plain)
        .allowsHitTesting(isEnabled)
    }
    
    // MARK: - Content View
    
    private var content: some View {
        Text(title)
            .applySolplyFont(.button_16_m)
            .foregroundStyle(isEnabled ? .coreWhite : .gray800)
            .frame(maxWidth: .infinity)
            .frame(height: 64.adjustedHeight)
            .background(
                Capsule()
                    .fill(isEnabled ? .gray900 : .gray300)
            )
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }

}
