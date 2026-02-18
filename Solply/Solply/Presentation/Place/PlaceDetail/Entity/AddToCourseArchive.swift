//
//  AddToCourseArchive.swift
//  Solply
//
//  Created by 김승원 on 2/14/26.
//

import Foundation

struct AddToCourseArchive {
    let courseId: Int
    let courseName: String
    let thumbnailImage: String
    let courseTag: CourseTagType
    let isBookmarked: Bool?
    let isDuplicated: Bool?
    let isPlaceCountLimited: Bool?
    let isActive: Bool?
}

