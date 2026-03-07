//
//  CourseRecommend.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct CourseRecommend: Identifiable, Equatable {
    let id: Int
    let courseName: String
    let imageUrl: String?
    let courseTagName: String
    let isBookmarked: Bool
}

extension CourseRecommend {
    init(dto: CourseDTO) {
        self.id = dto.courseId
        self.courseName = dto.courseName
        self.imageUrl = dto.thumbnailImage
        self.courseTagName = dto.courseTagName
        self.isBookmarked = dto.isBookmarked
    }
}
