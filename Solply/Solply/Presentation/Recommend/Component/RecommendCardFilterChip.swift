//
//  RecommendCardFilterChip.swift
//  Solply
//
//  Created by sun on 3/12/26.
//

import SwiftUI

struct RecommendCardFilterChip: View {
    
    // MARK: - Properties
    
    let title: String
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Text(title)
                .applySolplyFont(.body_14_m)
                .foregroundColor(.gray900)
        }
        .padding(.horizontal, 12.adjustedWidth)
        .padding(.vertical, 4.adjustedHeight)
        .frame(height: 32.adjustedWidth, alignment: .center)
        .background(
            Capsule()
                .fill(.gray100)
        )
    }
}
