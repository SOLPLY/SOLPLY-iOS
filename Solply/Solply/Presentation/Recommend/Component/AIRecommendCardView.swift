//
//  AIRecommendCardView.swift
//  Solply
//
//  Created by sun on 3/13/26.
//

import SwiftUI

struct AIRecommendCardView: View {
    
    // MARK: - Properties
    
    let mainTag: MainTagType
    let placeName: String
    let neighborhood: String
    let tipText: String
    let filters: [String]
    let thumbnailImageUrl: String?
    
    // MARK: - Initializer
    
    init(
        mainTag: MainTagType,
        placeName: String = "장소 이름",
        neighborhood: String = "동네",
        tipText: String = "조용한 분위기에서 혼자 작업하기 좋아요",
        filters: [String] = ["내용", "내용", "내용"],
        thumbnailImageUrl: String? = nil
    ) {
        self.mainTag = mainTag
        self.placeName = placeName
        self.neighborhood = neighborhood
        self.tipText = tipText
        self.filters = filters
        self.thumbnailImageUrl = thumbnailImageUrl
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.adjustedHeight) {
            thumbnailSection
            contentSection
            filterSection
        }
        .padding(.horizontal, 12.adjusted)
        .padding(.vertical, 12.adjusted)
        .frame(width: 343.adjustedWidth, alignment: .topLeading)
        .background(.white)
        .cornerRadius(20)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray300,
            borderWidth: 1
        )
    }
}

// MARK: - Sections

private extension AIRecommendCardView {
    
    var thumbnailSection: some View {
        ThumbnailImage(
            thumbnailImageUrl,
            width: 319.adjustedWidth,
            height: 204.adjustedHeight,
            radius: 16
        )
    }
    
    var contentSection: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            titleRow
            locationRow
            tipRow
        }
    }
    
    var titleRow: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            categoryBadge
            
            Text(placeName)
                .applySolplyFont(.display_16_sb)
                .foregroundStyle(.coreBlack)
                .lineLimit(1)
            
            Spacer()
            
            Image(.arrowRightIcon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 24.adjusted, height: 24.adjusted)
                .foregroundStyle(.gray600)
        }
    }
    
    var categoryBadge: some View {
        Text(mainTag.title)
            .applySolplyFont(.body_14_m)
            .foregroundStyle(mainTag.titleColor ?? .coreBlack)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(mainTag.backgroundColor ?? .clear)
            .clipShape(Capsule())
    }
    
    var locationRow: some View {
        HStack(alignment: .center, spacing: 6.adjustedWidth) {
            Image(.townIcon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 24.adjusted, height: 24.adjusted)
                .foregroundStyle(.gray600)
            
            Text(neighborhood)
                .applySolplyFont(.caption_14_m)
                .foregroundStyle(.gray600)
        }
    }
    
    var tipRow: some View {
        RecommendTipChip(
            text: tipText,
            tag: mainTag
        )
    }
    
    var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8.adjustedWidth) {
                ForEach(filters.indices, id: \.self) { index in
                    RecommendCardFilterChip(title: filters[index])
                }
            }
        }
        .padding(.bottom, 8.adjustedHeight)
        .scrollIndicators(.hidden)
    }
}
