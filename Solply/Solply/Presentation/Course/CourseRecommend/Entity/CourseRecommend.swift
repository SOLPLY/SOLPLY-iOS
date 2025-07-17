//
//  CourseRecommend.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct CourseRecommend: Identifiable, Equatable {
    let id: Int
    let title: String
    let imageUrl: String
    let courseCategory: [PlaceCategoryType]
    let isBookmarked: Bool
}

extension CourseRecommend {
    init(dto: CourseDTO) {
        self.id = dto.courseId
        self.title = dto.title
        self.imageUrl = dto.thumbnailImage
        self.courseCategory = dto.mainTags
        self.isBookmarked = dto.isBookmarked
    }
}
