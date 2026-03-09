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
    let thumbnailImage: String?
    let courseTagName: String
    let isBookmarked: Bool?
    let isDuplicated: Bool?
    let isPlaceCountLimited: Bool?
    let isActive: Bool?
}

extension CourseArchiveResponseDTO {
    func toEntity() -> [AddToCourseArchive] {
        return courses.map { course in
            AddToCourseArchive(
                courseId: course.courseId,
                courseName: course.courseName,
                thumbnailImage: course.thumbnailImage,
                courseTag: CourseTagType(rawValue: course.courseTagName) ?? .daily ,
                isBookmarked: course.isBookmarked,
                isDuplicated: course.isDuplicated,
                isPlaceCountLimited: course.isPlaceCountLimited,
                isActive: course.isActive
            )
        }
    }
}
