//
//  AICourseRecommendResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 4/26/26.
//

import Foundation

struct AICourseRecommendResponseDTO: ResponseModelType {
    let courses: [AIRecommendedCourse]
}

struct AIRecommendedCourse: ResponseModelType {
    let courseId: Int
    let courseName: String
    let thumbnailImageUrl: String
    let courseTag: String
    let townName: String
    let reason: String
    let placeMainTags: [String]
}
