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
                ForEach(popularPrompt, id: \.self) { string in
                    Button {
                        
                    } label: {
                        Text(string)
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

#Preview {
    PopularRecommend(popularPrompt: ["성수에서 작업하기 좋은 조용한 카페 추천해줘", "망원에서 혼자 오래 머물기 좋은 카페", "연남동 디저트가 맛있는 감성 카페", "서촌 사색하기 좋은 책방"])
}
