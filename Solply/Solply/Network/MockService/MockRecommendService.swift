//
//  MockRecommendService.swift
//  Solply
//
//  Created by 김승원 on 2/15/26.
//

import Foundation

final class MockRecommendService: BaseService<RecommendTargetType> { }

extension MockRecommendService: RecommendAPI {
    func fetchPlaceRecommend(townId: Int) async throws -> BaseResponseBody<PlaceRecommendResponseDTO> {
        let mock = PlaceRecommendResponseDTO(
            placeInfos: [
                PlaceInfoDTO(
                    placeId: 1,
                    placeName: "오감자",
                    thumbnailImageUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    mainTag: "카페",
                    introduction: "오감자는 맛있습니다"
                ),
                PlaceInfoDTO(
                    placeId: 2,
                    placeName: "눈을감자",
                    thumbnailImageUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    mainTag: "음식",
                    introduction: "눈을감자는 맛있습니다"
                ),
                PlaceInfoDTO(
                    placeId: 1,
                    placeName: "프링글스",
                    thumbnailImageUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    mainTag: "산책",
                    introduction: "프링글스는 제 취향은 아니네요"
                )
            ]
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func fetchCourseRecommend(townId: Int) async throws -> BaseResponseBody<CourseRecommendResponseDTO> {
        let mock = CourseRecommendResponseDTO(
            courses: [
                CourseDTO(
                    courseId: 1,
                    courseName: "오감을 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "데일리",
                    isBookmarked: false
                ),
                CourseDTO(
                    courseId: 2,
                    courseName: "육감을 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "취향·발견",
                    isBookmarked: true
                ),
                CourseDTO(
                    courseId: 3,
                    courseName: "칠감을 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "맛집·디저트",
                    isBookmarked: true
                ),
                CourseDTO(
                    courseId: 4,
                    courseName: "팔감을 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "산책·힐링",
                    isBookmarked: false
                ),
            ]
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
}
