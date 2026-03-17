//
//  AIRecommendCard.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import Foundation

enum AIRecommendCard: Identifiable, Equatable {
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

struct AIRecommendPlaceCardItem: Equatable {
    let id: String
    let mainTag: MainTagType
    let placeName: String
    let townName: String
    let tipText: String
    let filters: [String]
    let thumbnailImageUrl: String?
}

struct AIRecommendCourseCountItem: Equatable {
    let mainTag: String
    let count: Int
}

struct AIRecommendCourseCardItem: Equatable {
    let id: String
    let courseTagType: CourseTagType
    let courseName: String
    let townName: String
    let tipText: String
    let courseCounts: [AIRecommendCourseCountItem]
    let thumbnailImageUrl: String?
}

// TODO: - API 연결하면 지울게욥!!

extension AIRecommendCard {
    static let mockData: [AIRecommendCard] = [
        .place(
            AIRecommendPlaceCardItem(
                id: "1",
                mainTag: .cafe,
                placeName: "카페",
                townName: "포항",
                tipText: "조용한 분위기에서 혼자 작업하기 좋아요",
                filters: ["조용함", "콘센트", "와이파이"],
                thumbnailImageUrl: nil
            )
        ),
        .course(
            AIRecommendCourseCardItem(
                id: "2",
                courseTagType: .healing,
                courseName: "힐링이다",
                townName: "포항항",
                tipText: "산책하고 커피 마시기 좋은 코스예요",
                courseCounts: [
                    AIRecommendCourseCountItem(mainTag: "카페", count: 2),
                    AIRecommendCourseCountItem(mainTag: "산책", count: 1),
                    AIRecommendCourseCountItem(mainTag: "음식", count: 1),
                    AIRecommendCourseCountItem(mainTag: "서점/책방", count: 1)
                ],
                thumbnailImageUrl: nil
            )
        ),
        .place(
            AIRecommendPlaceCardItem(
                id: "3",
                mainTag: .food,
                placeName: "맛도리",
                townName: "포항항항",
                tipText: "혼밥하기 편하고 분위기가 아늑해요",
                filters: ["혼밥", "브런치", "분위기"],
                thumbnailImageUrl: nil
            )
        )
    ]
}
