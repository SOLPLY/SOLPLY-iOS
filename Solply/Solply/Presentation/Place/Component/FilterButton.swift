//
//  FilterButton.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct FilterButton: View {
    
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
            HStack(alignment: .center, spacing: 0) {
                Text(title)
                    .applySolplyFont(.body_14_m)
                Image(.arrowDownIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjustedWidth)
            }
            .foregroundStyle(.coreBlack)
            .background(.coreWhite)
            .padding(.vertical, 5.5.adjustedHeight)
            .padding(.leading, 12.adjustedWidth)
            .padding(.trailing, 4.adjustedWidth)
            .capsuleClipped()
            .addBorder(.capsule, borderColor: .gray300, borderWidth: 0.75)
        }
    }
}
