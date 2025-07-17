//
//  PlaceInformationRow.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import SwiftUI

struct PlaceInformationRow: View {
    
    // MARK: - Properties
    
    private let title: String
    private let value: String
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(title: String, value: String, action: (() -> Void)? = nil) {
        self.title = title
        self.value = value
        self.action = action
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 16.adjustedWidth) {
            Text(title)
                .applySolplyFont(.caption_14_m)
                .foregroundStyle(.coreBlack)
                .frame(width: 49.adjustedWidth, height: 21.adjustedHeight, alignment: .leading)
                .cornerRadius(10, corners: .allCorners)
            
            if let action {
                Button {
                    action()
                } label: {
                    Text(value)
                        .applySolplyFont(.caption_14_r)
                        .underline()
                        .foregroundStyle(.coreBlack)
                }
                .buttonStyle(.plain)
            } else {
                Text(value)
                    .applySolplyFont(.caption_14_r)
                    .foregroundStyle(.coreBlack)
            }
        }
    }
}
