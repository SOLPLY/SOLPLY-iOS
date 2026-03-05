//
//  PlaceCard.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

import SwiftUI

import Kingfisher

struct PlaceCard: View {
    
    // MARK: - Properties
    
    private let isSaved: Bool
    private let thumbnailUrl: String?
    private let placeName: String
    private let placeCategory: MainTagType
    private let isSelected: Bool
    private let size: CGFloat
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isSaved: Bool,
        thumbnailUrl: String?,
        placeName: String,
        placeCategory: MainTagType,
        isSelected: Bool,
        size: CGFloat = 165.adjusted,
        action: (() -> Void)? = nil
    ) {
        self.isSaved = isSaved
        self.thumbnailUrl = thumbnailUrl
        self.placeName = placeName
        self.placeCategory = placeCategory
        self.isSelected = isSelected
        self.size = size
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            ZStack(alignment: .topTrailing) {
                ThumbnailImage(
                    thumbnailUrl,
                    width: size,
                    height: size,
                    radius: 0
                )
                
                if isSaved {
                    Image(placeCategory.savedBadge ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 32.adjustedHeight)
                        .padding(.horizontal, 16.adjustedWidth)
                }
            }
            .cornerRadius(20, corners: .allCorners)
            
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                PlaceCategoryTag(placeCategory: placeCategory)
                Text(placeName)
                    .applySolplyFont(.body_14_m)
                    .foregroundStyle(.coreBlack)
                    .frame(height: 19.adjustedHeight)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

