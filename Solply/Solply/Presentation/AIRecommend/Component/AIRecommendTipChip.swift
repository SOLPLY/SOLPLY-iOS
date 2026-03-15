//
//  AIRecommendTipChip.swift
//  Solply
//
//  Created by sun on 3/11/26.
//

import SwiftUI

struct AIRecommendTipChip: View {
    
    let text: String
    let tag: AIRecommendType
    
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
