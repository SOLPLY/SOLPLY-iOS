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
    
    private let thumbnailImageUrl: String?
    private let category: MainTagType
    private let title: String
    private let introduction: String
    private let onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        thumbnailImageUrl: String?,
        category: MainTagType,
        title: String,
        introduction: String,
        onTap: (() -> Void)? = nil
    ) {
        self.thumbnailImageUrl = thumbnailImageUrl
        self.category = category
        self.title = title
        self.introduction = introduction
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ThumbnailImage(
                thumbnailImageUrl,
                width: 240.adjusted,
                height: 240.adjusted,
                radius: 20
            )
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                startPoint: .bottom,
                endPoint: .center
            )
            .frame(width: 240.adjusted, height: 240.adjusted)
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
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}
