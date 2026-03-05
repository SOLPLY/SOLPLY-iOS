//
//  SeletableChipsFlowView.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct SeletableChipsFlowView: View {
    
    // MARK: - Properites
    
    @Binding private var tags: [SelectableSubTag]
    
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    
    // MARK: - Initializer
    
    init(
        tags: Binding<[SelectableSubTag]>,
        horizontalSpacing: CGFloat = 8.adjusted,
        verticalSpacing: CGFloat = 8.adjusted
    ) {
        self._tags = tags
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }

    var body: some View {
        CustomFlowLayout(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
            ForEach(tags.indices, id: \.self) { index in
                SubTagChip(
                    title: tags[index].name.title,
                    isSelected: tags[index].isSelected
                )
                .onTapGesture {
                    tags[index].isSelected.toggle()
                }
            }
        }
    }
}
