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
    let title: String
    let placeCount: Int?
    let thumbnailImage: String
    let mainTags: [PlaceCategoryType]
    let isBookmarked: Bool
    let isActive: Bool?
}
