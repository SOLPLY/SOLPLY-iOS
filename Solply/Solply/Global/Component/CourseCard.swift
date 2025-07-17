//
//  CourseCard.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

import SwiftUI

import Kingfisher

struct CourseCard: View {
    
    // MARK: - Properties
    
    private let isSaved: Bool
    private let title: String
    private let imageURL: String
    private let courseCategory: [PlaceCategoryType]
    private let isSelected: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isSaved: Bool,
        title: String,
        imageURL: String,
        courseCategory: [PlaceCategoryType],
        isSelected: Bool,
        action: (() -> Void)? = nil
    ) {
        self.isSaved = isSaved
        self.title = title
        self.imageURL = imageURL
        self.courseCategory = courseCategory
        self.isSelected = isSelected
        self.action = action
    }
    
    // MARK: - Body

    var body: some View {
        Button {
            action?()
        } label: {
            ZStack(alignment: .bottom) {
                KFImage(URL(string: imageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                    .cornerRadius(20, corners: .allCorners)
                
                Rectangle()
                    .frame(width: 165.adjustedWidth, height: 11.adjustedHeight)
                    .foregroundStyle(.coreBlackO20)
                    .padding(.bottom, 84.adjustedHeight)
                
                VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                    HStack(alignment: .center, spacing: 0) {
                        Text(title)
                            .applySolplyFont(.title_14_m)
                            .foregroundStyle(.coreBlack)
                            .frame(height: 38.adjustedHeight)
                        
                        Spacer()
                        
                        if isSaved, let isSavedBadge = courseCategory.first?.savedBadge {
                            Image(isSavedBadge)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                    }
                    .padding(.top, 8.adjustedHeight)
                    .padding(.horizontal, 12.adjustedWidth)
                    
                    HStack(alignment: .center, spacing: 4.adjustedWidth) {
                        ForEach(courseCategory.prefix(2), id: \.self) { category in
                            PlaceCategoryTag(placeCategory: category)
                                .frame(height: 20.adjustedHeight)
                        }
                    }
                    .padding(.bottom, 12.adjustedHeight)
                    .padding(.leading, 12.adjustedWidth)
                }
                .frame(width: 165.adjustedWidth, height: 88.adjustedHeight)
                .background(courseCategory.first?.courseBackgroundColor)
                .cornerRadius(4, corners: [.topLeft, .topRight])
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            }
        }
        .buttonStyle(.plain)
    }
}
