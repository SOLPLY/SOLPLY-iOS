//
//  CourseRecommendGrid.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct CourseRecommendGrid: View {
    
    // MARK: - Properties
    
    private let columns = [
        GridItem(.fixed(165.adjustedWidth), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(165.adjustedWidth))
    ]
    private let placeCategory: PlaceCategoryType = .all
    private let courseDetailAction: ((Int) -> Void)?
    
    init(courseDetailAction: ((Int) -> Void)? = nil) {
        self.courseDetailAction = courseDetailAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                ForEach(0..<10) { index in
                    CourseCard(
                        isSaved: true,
                        title: "오감으로 수집하는 하루",
                        // TODO: - 이미지 수정 필요
                        image: "",
                        courseCategory: [.book, .cafe],
                        isSelected: true
                    ) {
                        // TODO: 코스 id 바인딩 필요!
                        courseDetailAction?(1)
                    }
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}
