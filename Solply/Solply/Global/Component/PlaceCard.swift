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
    private let thumbnailUrl: String
    private let placeName: String
    private let placeCategory: MainTagType
    private let isSelected: Bool
    private let size: CGFloat
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isSaved: Bool,
        thumbnailUrl: String,
        placeName: String,
        placeCategory: MainTagType,
        isSelected: Bool,
        size: CGFloat = 165,
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
            ZStack(alignment: .bottomTrailing) {
                KFImage(URL(string: thumbnailUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.adjustedWidth, height: size.adjustedHeight)
                    .cornerRadius(20, corners: .allCorners)
                
                if isSaved {
                    Image(placeCategory.savedBadge ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        .padding(.horizontal, 12.adjustedWidth)
                        .padding(.vertical, 12.adjustedHeight)
                }
            }
            
            HStack(alignment: .top, spacing: 4.adjustedWidth) {
                PlaceCategoryTag(placeCategory: placeCategory)
                Text(placeName)
                    .applySolplyFont(.body_14_m)
                    .foregroundStyle(.coreBlack)
                    .frame(alignment: .topLeading)
            }
        }
        .onTapGesture {
            action?()
        }
    }
}

#Preview {
    PlaceCard(isSaved: true, thumbnailUrl: "", placeName: "안녕하십니까링가링가링가링가링가리어어아아ㅏ아", placeCategory: .cafe, isSelected: true, size: 165) {
        print("gd")
    }
}
