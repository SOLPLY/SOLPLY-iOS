//
//  PlaceCellButton.swift
//  Solply
//
//  Created by 김승원 on 7/9/25.
//

import SwiftUI

struct PlaceCellButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(title: String, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .applySolplyFont(.button_12_m)
                .foregroundStyle(.coreBlack)
                .frame(width: 76.adjustedWidth, height: 32.adjustedHeight)
                .background(.gray200)
                .capsuleClipped()
                .addBorder(.capsule, borderColor: .gray300, borderWidth: 1)
        }
        .buttonStyle(.plain)
    }
}
