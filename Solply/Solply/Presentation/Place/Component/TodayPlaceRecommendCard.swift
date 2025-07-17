//
//  TodayPlaceRecommendCard.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import SwiftUI

import Kingfisher

struct TodayPlaceRecommendCard: View {
    
    // MARK: - Properties
    
    private let thumbnailImageUrl: String
    private let category: MainTagType
    private let title: String
    private let introduction: String
    
    // MARK: - Initializer
    
    init(
        thumbnailImageUrl: String,
        category: MainTagType,
        title: String,
        introduction: String
    ) {
        self.thumbnailImageUrl = thumbnailImageUrl
        self.category = category
        self.title = title
        self.introduction = introduction
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(URL(string: thumbnailImageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 240.adjustedWidth, height: 240.adjustedHeight)
                .cornerRadius(20, corners: .allCorners)
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                startPoint: .bottom,
                endPoint: .center
            )
            .frame(width: 240.adjustedWidth, height: 240.adjustedHeight)
            .cornerRadius(20, corners: .allCorners)
            .allowsHitTesting(false)
            
            VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                PlaceCategoryTag(placeCategory: category)
                
                Text(title)
                    .applySolplyFont(.display_16_sb)
                    .foregroundStyle(.coreWhite)
                
                Text(introduction)
                    .applySolplyFont(.display_12_r)
                    .foregroundStyle(.coreWhite)
                    .lineLimit(2)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.bottom, 16.adjustedHeight)
        }
    }
}
