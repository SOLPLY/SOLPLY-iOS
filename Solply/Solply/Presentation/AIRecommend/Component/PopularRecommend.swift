//
//  PopularRecommend.swift
//  Solply
//
//  Created by seozero on 3/12/26.
//

import SwiftUI

struct PopularRecommend: View {
    
    // MARK: - Properties

    let popularPrompt: [String]
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            Text("인기 추천 바로가기")
                .applySolplyFont(.title_14_m)
                .foregroundStyle(.gray800)
                .padding(.leading, 4.adjustedWidth)
            
            VStack(alignment: .center, spacing: 12.adjustedHeight) {
                ForEach(popularPrompt, id: \.self) { prompt in
                    Button {
                        
                    } label: {
                        Text(prompt)
                            .applySolplyFont(.body_14_r)
                            .foregroundStyle(.coreBlack)
                            .padding(.horizontal, 20.adjustedWidth)
                            .frame(
                                width: 343.adjustedWidth,
                                height: 49.adjustedHeight,
                                alignment: .leading
                            )
                            .addBorder(
                                .roundedRectangle(cornerRadius: 20),
                                borderColor: .gray200,
                                borderWidth: 1.adjustedWidth
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
