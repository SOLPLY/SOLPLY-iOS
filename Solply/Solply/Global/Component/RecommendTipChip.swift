//
//  RecommendTipChip.swift
//  Solply
//
//  Created by sun on 3/11/26.
//

import SwiftUI

struct RecommendTipChip: View {
    
    // MARK: - Properties
    
    let text: String
    let tag: MainTagType
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top, spacing: 4.adjustedWidth) {
            
            if let icon = tag.aiIcon {
                Image(icon)
                    .resizable()
                    .frame(width: 16.adjusted, height: 16.adjusted)
            }
            
            Text(text)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(tag.titleColor ?? .coreBlack)
                .multilineTextAlignment(.leading)
        }
    }
}
