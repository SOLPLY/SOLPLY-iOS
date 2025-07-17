//
//  CourseRecommendResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct CourseRecommendResponseDTO: ResponseModelType {
    let courses: [CourseDTO]
}

struct CourseDTO: ResponseModelType {
    let courseId: Int
    let courseName: String
    let thumbnailImage: String
    let mainTags: [MainTagType]
    let isBookmarked: Bool
}
