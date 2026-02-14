//
//  CourseRecommendGrid.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct CourseRecommendGrid: View {
    
    // MARK: - Properties
    
    @ObservedObject var store: CourseRecommendStore
    
    private let columns = [
        GridItem(.fixed(165.adjusted), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(165.adjusted))
    ]
    private let placeCategory: MainTagType = .all
    private let courseDetailAction: ((Int) -> Void)?
    
    init(
        store: CourseRecommendStore,
        courseDetailAction: ((Int) -> Void)? = nil
    ) {
        self.store = store
        self.courseDetailAction = courseDetailAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                ForEach(store.state.courses) { course in
                    CourseCard(
                        isSaved: course.isBookmarked,
                        courseName: course.courseName,
                        imageUrl: course.imageUrl,
                        courseTagType: CourseTagType.init(rawValue: course.courseTagName) ?? .daily,
                        isSelected: true
                    ) {
                        courseDetailAction?(course.id)
                    }
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}
