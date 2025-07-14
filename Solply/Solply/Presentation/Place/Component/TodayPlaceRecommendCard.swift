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
    private let category: PlaceCategoryType
    private let title: String
    private let desciption: String
    
    // MARK: - Initializer
    
    init(
        backgroundImage: UIImage,
        category: PlaceCategoryType,
        title: String,
        description: String
    ) {
        self.backgroundImage = backgroundImage
        self.category = category
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
                PlaceCategoryTag(placeCategory: category)
                
                Text(title)
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
