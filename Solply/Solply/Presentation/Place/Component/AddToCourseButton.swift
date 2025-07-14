//
//  AddToCourseButton.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import SwiftUI

struct AddToCourseButton: View {
    
    // MARK: - Properties
    
    private var isSelected: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(isSelected: Bool, action: (() -> Void)? = nil) {
        self.isSelected = isSelected
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text("내 코스에 추가")
                .applySolplyFont(.button_14_m)
                .foregroundStyle(isSelected ? .purple800: .purple600)
                .frame(width: 112.adjustedWidth, height: 47.adjustedHeight,)
                .background(isSelected ? .purple400 : .coreWhite)
                .capsuleClipped()
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}
