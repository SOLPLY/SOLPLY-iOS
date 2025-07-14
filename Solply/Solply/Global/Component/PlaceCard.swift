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
    private let isSelected: Bool
    private let size: CGFloat
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isSaved: Bool,
        title: String,
        placeCategory: PlaceCategoryType,
        isSelected: Bool,
        size: CGFloat = 165.adjustedWidth,
        action: (() -> Void)? = nil
    ) {
        self.isSaved = isSaved
        self.title = title
        self.placeCategory = placeCategory
        self.isSelected = isSelected
        self.size = size
        self.action = action
    }
    
    // MARK: - Body

    var body: some View {
        Button {
            action?()
        } label: {
            VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                ZStack(alignment: .bottomTrailing) {
                    Image(.place)
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
                
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    PlaceCategoryTag(placeCategory: placeCategory)
                    Text(title)
                        .applySolplyFont(.body_14_m)
                        .foregroundStyle(.coreBlack)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
