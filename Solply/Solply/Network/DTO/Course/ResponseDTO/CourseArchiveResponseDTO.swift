//
//  CourseArchiveResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

struct CourseArchiveResponseDTO: ResponseModelType {
    let courses: [CourseArchiveDTO]
}

struct CourseArchiveDTO: ResponseModelType {
    let courseId: Int
    let courseName: String
    let thumbnailImage: String
    let mainTags: [PlaceCategoryType]
    let isBookmarked: Bool?
    let isDuplicated: Bool?
    let isPlaceCountLimited: Bool?
    let isActive: Bool?
}
