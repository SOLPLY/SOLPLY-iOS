//
//  AIRecommendCard.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import Foundation

enum AIRecommendCard: Identifiable, Equatable, Hashable {
    case place(AIRecommendPlaceCardItem)
    case course(AIRecommendCourseCardItem)

    var id: String {
        switch self {
        case .place(let entity):
            return "place_\(entity.id)"
        case .course(let entity):
            return "course_\(entity.id)"
        }
    }
}

struct AIRecommendPlaceCardItem: Equatable, Hashable {
    let id: Int
    let mainTag: MainTagType
    let placeName: String
    let townId: Int
    let townName: String
    let tipText: String
    let filters: [String]
    let thumbnailImageUrl: String?
}

struct AIRecommendCourseCountItem: Equatable, Hashable {
    let mainTag: String
    let count: Int
}

struct AIRecommendCourseCardItem: Equatable, Hashable {
    let id: Int
    let courseTagType: CourseTagType
    let courseName: String
    let townId: Int
    let townName: String
    let tipText: String
    let courseCounts: [AIRecommendCourseCountItem]
    let thumbnailImageUrl: String?
}
