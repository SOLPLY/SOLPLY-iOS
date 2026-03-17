//
//  AIRecommendTipChip.swift
//  Solply
//
//  Created by sun on 3/11/26.
//

import SwiftUI

struct AIRecommendTipChip: View {
    
    // MARK: - Properties
    
    let text: String
    let tag: AIRecommendType
    
    // MARK: - Initializer
    
    init(
        text: String,
        tag: AIRecommendType
    ) {
        self.text = text
        self.tag = tag
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top, spacing: 4.adjustedWidth) {
            
            if let icon = tag.icon {
                Image(icon)
                    .resizable()
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
            
            Text(text)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(tag.titleColor)
        }
    }
}
