//
//  AIRecommendPromptText.swift
//  Solply
//
//  Created by sun on 3/17/26.
//

import SwiftUI

struct AIRecommendPromptText: View {
    
    // MARK: - Properties
    
    let prompt: String
    
    // MARK: - Init
    
    init(prompt: String) {
        self.prompt = prompt
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray100)
                .frame(height: 52.adjustedHeight)
                .addBorder(
                    .roundedRectangle(cornerRadius: 20),
                    borderColor: .gray300,
                    borderWidth: 1
                )

            HStack(alignment: .center, spacing: 0) {
                Text(prompt)
                    .applySolplyFont(.body_14_r)
                    .foregroundColor(.gray900)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20.adjustedWidth)
        }
    }
}
