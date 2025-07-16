//
//  CourseArchiveThumbnailResponseDTO.swift
//  Solply
//
//  Created by LEESOOYONG on 7/16/25.
//

import Foundation

struct CourseArchiveThumbnailResponseDTO: ResponseModelType {
    let folders: [CourseArchiveThumbnailDTO]
}

struct CourseArchiveThumbnailDTO: ResponseModelType {
    let townId: Int?
    let townName: String?
    let courseName: String?
    let primaryTags: [String]?
    let thumbnailUrl: String?
}
