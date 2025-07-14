//
//  TodayPlaceRecommendCard.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import SwiftUI

struct TodayPlaceRecommendCard: View {
    
    // MARK: - Properties
    
    private let backgroundImage: UIImage
    private let title: String
    private let desciption: String
    
    // MARK: - Initializer
    
    init(
        backgroundImage: UIImage,
        title: String,
        description: String
    ) {
        self.backgroundImage = backgroundImage
        self.title = title
        self.desciption = description
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(.temp)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                // TODO: 태그 컴포넌트 만들어지면 추가하기
                
                Text(title)
                // TODO: 줄간격 확인해보기
                    .applySolplyFont(.display_16_sb)
                    .foregroundStyle(.coreWhite)
                
                Text(desciption)
                    .applySolplyFont(.display_12_r)
                    .foregroundStyle(.coreWhite)
                    .lineLimit(2)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(width: 240.adjustedWidth, height: 240.adjustedHeight)
    }
}
