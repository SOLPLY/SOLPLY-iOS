//
//  RecommendTipChip.swift
//  Solply
//
//  Created by sun on 3/11/26.
//

import SwiftUI

struct RecommendTipChip: View {
    
    let text: String
    let tag: MainTagType
    
    var body: some View {
        HStack(spacing: 4) {
            
            if let icon = tag.aiIcon {
                Image(icon)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            
            Text(text)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(tag.titleColor ?? .coreBlack)
        }
    }
}
