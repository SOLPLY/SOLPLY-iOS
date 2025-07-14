//
//  ArchiveBar.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import SwiftUI

struct ArchiveBar: View {
    private let archiveCategory: [SolplyContentType] = [.place, .course]
    private let action: ((SolplyContentType) -> Void)?
    private let selected: SolplyContentType
    
    @Namespace private var namespace
    
    init(selected: SolplyContentType, action: ((SolplyContentType) -> Void)? = nil) {
        self.selected = selected
        self.action = action
    }
    
    var body: some View {
        HStack {
            ForEach(archiveCategory, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        Capsule()
                            .fill(.gray800)
                            .matchedGeometryEffect(id: "categoryUnderLine", in: namespace)
                            .frame(width: 181.adjustedWidth, height: 3.adjustedHeight)
                            .offset(y:14.adjustedHeight)
                    }
                    Text(category.title)
                        .foregroundColor(selected == category ? .coreBlack : .gray800)
                        .applySolplyFont(.head_15_sb)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 48.adjustedHeight)
                .onTapGesture {
                    withAnimation(.spring()) {
                        action?(category)
                    }
                }
            }
        }
    }
}
