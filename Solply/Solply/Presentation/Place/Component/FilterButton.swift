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
    private let selectedSubTagsCount: Int
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        selectedSubTagsCount: Int = 0,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.selectedSubTagsCount = selectedSubTagsCount
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    Text(title)
                        .applySolplyFont(selectedSubTagsCount == 0 ? .body_14_r : .body_14_m)
                        .foregroundStyle(.coreBlack)
                    
                    if selectedSubTagsCount > 1 {
                        Text("외 \(selectedSubTagsCount - 1)개")
                            .applySolplyFont(.body_14_r)
                            .foregroundStyle(.coreBlack)
                    }
                }
                Image(.arrowDownIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
            .foregroundStyle(.coreBlack)
            .padding(.vertical, 5.5.adjustedHeight)
            .padding(.leading, 12.adjustedWidth)
            .padding(.trailing, 4.adjustedWidth)
            .background(selectedSubTagsCount == 0 ? .coreWhite : .gray100)
            .capsuleClipped()
            .addBorder(
                .capsule,
                borderColor: .gray300,
                borderWidth: selectedSubTagsCount == 0 ? 0.75 : 1
            )
        }
        .buttonStyle(.plain)
    }
}
