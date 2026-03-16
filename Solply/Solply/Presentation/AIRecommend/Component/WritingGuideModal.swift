//
//  WritingGuideModal.swift
//  Solply
//
//  Created by seozero on 3/12/26.
//

import SwiftUI

struct WritingGuideModal: View {
    
    // MARK: - Properties
    
    let type: SolplyContentType
    
    // MARK: - Initializer
    
    init(_ type: SolplyContentType) {
        self.type = type
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                Text(type.aiRecommendGuideTitle)
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    ForEach(type.aiRecommendGuideContents, id: \.self) { content in
                        TextWithBulletIcon(content)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.vertical, 20.adjustedHeight)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.coreWhite)
            )
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}
