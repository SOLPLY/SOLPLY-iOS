//
//  FindDirectionButton.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import SwiftUI

struct FindDirectionButton: View {
    
    // MARK: - Properties
    
    private var isEnabled: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(isEnabled: Bool, action: (() -> Void)? = nil) {
        self.isEnabled = isEnabled
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 47.adjustedWidth, height: 47.adjustedHeight)
                    .foregroundStyle(.coreWhite)
                
                Image(.tempIcon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23.adjustedWidth, height: 23.adjustedHeight)
                    .foregroundStyle(isEnabled ? .purple600 : .gray400)
            }
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
        }
        .allowsHitTesting(isEnabled)
        .buttonStyle(.plain)
    }
}
