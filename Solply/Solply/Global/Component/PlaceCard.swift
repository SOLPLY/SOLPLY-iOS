//
//  PlaceCard.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

import SwiftUI

struct PlaceCard: View {
    
    // MARK: - Properties
    
    private let isSaved: Bool
    private let title: String
    private let placeCategory: PlaceCategoryType
    
    // MARK: - Initializer
    
    init(isSaved: Bool, title: String, placeCategory: PlaceCategoryType) {
        self.isSaved = isSaved
        self.title = title
        self.placeCategory = placeCategory
    }
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            ZStack(alignment: .bottomTrailing) {
                Image(.place)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                    .cornerRadius(20, corners: .allCorners)
                
                if isSaved {
                    Image(placeCategory.savedBadge ?? "")
                        .resizable()
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 12.adjustedWidth)
                        .padding(.vertical, 12.adjustedHeight)
                }
            }
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                PlaceCategoryTag(placeCategory: placeCategory)
                Text(title)
                    .applySolplyFont(.body_14_m)
                    .foregroundStyle(.coreBlack)
            }
        }
    }
}
