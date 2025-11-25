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
    private let courseName: String
    private let imageUrl: String
    private let courseCategory: [MainTagType]
    private let isSelected: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isSaved: Bool,
        courseName: String,
        imageUrl: String,
        courseCategory: [MainTagType],
        isSelected: Bool,
        action: (() -> Void)? = nil
    ) {
        self.isSaved = isSaved
        self.courseName = courseName
        self.imageUrl = imageUrl
        self.courseCategory = courseCategory
        self.isSelected = isSelected
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 165.adjusted, height: 165.adjusted)
            
            Rectangle()
                .frame(width: 165.adjusted, height: 93.adjusted)
                .foregroundStyle(.coreBlackO20)
                .cornerRadius(4, corners: [.topLeft, .topRight])
            
            VStack(alignment: .leading, spacing: 12.adjusted) {
                HStack(alignment: .top, spacing: 0) {
                    Text(courseName)
                        .applySolplyFont(.title_14_m)
                        .foregroundStyle(.coreBlack)
                        .frame(height: 38.adjusted, alignment: .topLeading)
                        .padding(.top, 8.adjusted)
                    
                    Spacer()
                    
                    if isSaved, let isSavedBadge = courseCategory.first?.savedBadge {
                        Image(isSavedBadge)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjusted, height: 32.adjusted)
                    }
                }
                .padding(.horizontal, 12.adjusted)
                
                HStack(alignment: .center, spacing: 4.adjusted) {
                    ForEach(courseCategory.prefix(2), id: \.self) { category in
                        PlaceCategoryTag(placeCategory: category)
                            .frame(height: 20.adjusted)
                    }
                }
                .padding(.bottom, 12.adjusted)
                .padding(.leading, 12.adjusted)
            }
            .frame(width: 165.adjusted, height: 88.adjusted)
            .background(courseCategory.first?.courseBackgroundColor)
            .cornerRadius(4, corners: [.topLeft, .topRight])
        }
        .frame(width: 165.adjusted, height: 165.adjusted)
        .background(.blue)
        .cornerRadius(20, corners: .allCorners)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}
