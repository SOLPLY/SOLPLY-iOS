//
//  WritingGuideModal.swift
//  Solply
//
//  Created by seozero on 3/12/26.
//

import SwiftUI

struct WritingGuideModal: View {
    
    // MARK: - Properties
    
    let type: WritingGuideType
    
    // MARK: - Body
    
    var body: some View {
        Group {
            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                Text(type.title)
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    ForEach(type.contents, id: \.self) { content in
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
