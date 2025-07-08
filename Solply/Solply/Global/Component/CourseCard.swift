//
//  CourseCard.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

import SwiftUI

struct CourseCard: View {
    
    // MARK: - Properties
    
    private let isSaved: Bool
    private let title: String
    private let courseCategory: [PlaceCategoryType]
    
    // MARK: - Initializer
    
    init(isSaved: Bool, title: String, courseCategory: [PlaceCategoryType]) {
        self.isSaved = isSaved
        self.title = title
        self.courseCategory = courseCategory
    }
    
    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.place)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                .cornerRadius(20, corners: .allCorners)
            
            Rectangle()
                .frame(width: 165.adjustedWidth, height: 11.adjustedHeight)
                .foregroundStyle(.coreBlackO20)
                .padding(.bottom, 84.adjustedHeight)
            
            VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                HStack(alignment: .center) {
                    Text(title)
                        .applySolplyFont(.title_14_m)
                        .foregroundStyle(.coreBlack)
                        .frame(height: 36.adjustedHeight)
                    
                    Spacer()
                    
                    if isSaved, let isSavedBadge = courseCategory.first?.savedBadge {
                        Image(isSavedBadge)
                            .aspectRatio(contentMode: .fit)
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
            .frame(width: 165.adjustedWidth ,height: 88.adjustedHeight)
            .background(courseCategory.first?.courseBackgroundColor)
            .cornerRadius(4, corners: [.topLeft, .topRight])
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
        }
    }
}

#Preview {
    CourseCard(isSaved: true, title: "오감으로 수집하는 하루", courseCategory: [.food, .unique])
}
