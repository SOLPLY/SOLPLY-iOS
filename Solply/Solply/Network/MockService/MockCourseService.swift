//
//  MockCourseService.swift
//  Solply
//
//  Created by 김승원 on 2/15/26.
//

import Foundation

final class MockCourseService: BaseService<CourseTargetType> { }

// MARK: - CourseAPI

extension MockCourseService: CourseAPI {
    func submitCreateCourseDetail(request: CourseCreateRequestDTO) async throws -> BaseResponseBody<CourseCreateResponseDTO> {
        let mock = CourseCreateResponseDTO(courseId: 1)
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func updateCourseDetail(courseId: Int, request: CourseUpdateRequestDTO) async throws -> BaseResponseBody<CourseUpdateResponseDTO> {
        let mock = CourseUpdateResponseDTO(
            updatedCourseId: 1,
            updatedCourseName: "오감으로 수집하는 하루",
            updatedCourseDescription: "오감 육감 칠감 팔감",
            updatedCourseTagName: "데일리",
            isNewCourse: false
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func submitAddPlace(courseId: Int, placeId: Int) async throws -> BaseResponseBody<CourseAddPlaceResponseDTO> {
        let mock = CourseAddPlaceResponseDTO(
            courseId: 1,
            courseName: "오감으로 수집하는 하루",
            isNewCourse: false,
            addedPlaceInfo: AddedPlaceInformationDTO(
                placeId: 1,
                placeOrder: 1
            )
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func fetchCourseArchive(townId: Int?, placeId: Int?) async throws -> BaseResponseBody<CourseArchiveResponseDTO> {
        let mock = CourseArchiveResponseDTO(
            courses: [
                CourseArchiveDTO(
                    courseId: 1,
                    courseName: "오감으로 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "데일리",
                    isBookmarked: true,
                    isDuplicated: true,
                    isPlaceCountLimited: true,
                    isActive: false
                ),
                CourseArchiveDTO(
                    courseId: 2,
                    courseName: "육감으로 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "취향·발견",
                    isBookmarked: true,
                    isDuplicated: false,
                    isPlaceCountLimited: false,
                    isActive: true
                ),
                CourseArchiveDTO(
                    courseId: 3,
                    courseName: "칠감으로 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "맛집·디저트",
                    isBookmarked: true,
                    isDuplicated: false,
                    isPlaceCountLimited: true,
                    isActive: false
                ),
                CourseArchiveDTO(
                    courseId: 4,
                    courseName: "팔감으로 수집하는 하루",
                    thumbnailImage: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    courseTagName: "산책·힐링",
                    isBookmarked: true,
                    isDuplicated: false,
                    isPlaceCountLimited: false,
                    isActive: true
                )
            ]
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func fetchCourseDetail(courseId: Int) async throws -> BaseResponseBody<CourseDetailResponseDTO> {
        let mock = CourseDetailResponseDTO(
            courseId: 1,
            courseName: "오감으로 수집하는 하루",
            introduction: "오감자, 눈을감자, 프링글스 냠냠",
            courseTagName: "맛집·디저트",
            isBookmarked: false,
            places: [
                CourseDetailPlaceDTO(
                    placeId: 1,
                    placeName: "오감자",
                    thumbnailUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    primaryTag: .food,
                    address: "서울 강서구 등촌동 682-2",
                    isBookmarked: true,
                    placeOrder: 1,
                    latitude: "37.49821",
                    longitude: "127.02794",
                    placeType: "FOOD",
                    placeDefaultId: 1005
                ),
                CourseDetailPlaceDTO(
                    placeId: 2,
                    placeName: "눈을감자",
                    thumbnailUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg",
                    primaryTag: .cafe,
                    address: "서울 강서구 등촌동 682-2",
                    isBookmarked: true,
                    placeOrder: 1,
                    latitude: "37.49763",
                    longitude: "127.02688",
                    placeType: "CAFE",
                    placeDefaultId: 1006
                )
            ]
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func fetchCourseThumbnail() async throws -> BaseResponseBody<CourseArchiveThumbnailResponseDTO> {
        let mock = CourseArchiveThumbnailResponseDTO(
            folders: [
                CourseArchiveThumbnailDTO(
                    townId: 2,
                    townName: "망원동",
                    courseName: "오감으로 수집하는 하루",
                    courseTagName: "맛집·디저트",
                    thumbnailUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg"
                ),
                CourseArchiveThumbnailDTO(
                    townId: 3,
                    townName: "연남동",
                    courseName: "오감으로 수집하는 하루",
                    courseTagName: "취향·발견",
                    thumbnailUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/25/place_025_image_1.jpg"
                )
            ]
        )
        
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func submitCourseBookmark(courseId: Int) async throws -> BaseResponseBody<EmptyResponseDTO> {
        let mock = EmptyResponseDTO()
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func removeCourseBookmark(courseId: Int) async throws -> BaseResponseBody<EmptyResponseDTO> {
        let mock = EmptyResponseDTO()
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
    
    func removeCourseList(courseIds: [Int]) async throws -> BaseResponseBody<EmptyResponseDTO> {
        let mock = EmptyResponseDTO()
        let response = BaseResponseBody.mockSuccess(data: mock)
        return response
    }
}
