//
//  CourseSaveButton.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import SwiftUI

struct CourseSaveButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(title: String, action: (() -> Void)?) {
        self.title = title
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .applySolplyFont(.button_16_m)
                .foregroundStyle(.gray900)
                .frame(width: 335.adjustedWidth, height: 64.adjustedHeight)
                .background(.coreWhite)
                .capsuleClipped()
        }
        .buttonStyle(.plain)
    }
}
