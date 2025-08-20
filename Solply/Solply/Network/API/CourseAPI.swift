//
//  CourseAPI.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

protocol CourseAPI {
    /// 코스 생성
    func submitCreateCourseDetail(
        request: CourseCreateRequestDTO
    ) async throws -> BaseResponseBody<CourseCreateResponseDTO>
    
    /// 코스 수정
    func updateCourseDetail(
        courseId: Int,
        request: CourseUpdateRequestDTO
    ) async throws -> BaseResponseBody<CourseUpdateResponseDTO>
    
    /// 코스에 장소 추가
    func submitAddPlace(
        courseId: Int,
        placeId: Int
    ) async throws -> BaseResponseBody<CourseAddPlaceResponseDTO>
    
    /// 내 코스 리스트 조회
    func fetchCourseArchive(
        townId: Int,
        placeId: Int?
    ) async throws -> BaseResponseBody<CourseArchiveResponseDTO>
    
    /// 코스 상세 조회(단건)
    func fetchCourseDetail(
        courseId: Int
    ) async throws -> BaseResponseBody<CourseDetailResponseDTO>
    
    /// "나만의 코스" 폴더 썸네일 조회
    func fetchCourseThumbnail() async throws -> BaseResponseBody<CourseArchiveThumbnailResponseDTO>
    
    /// "나만의 코스" 저장(북마크)
    func submitCourseBookmark(
        courseId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO>
    
    /// "나만의 코스" 삭제(북마크)
    func removeCourseBookmark(courseId: Int) async throws -> BaseResponseBody<EmptyResponseDTO>

    /// 선택한 "나만의 코스" 삭제
    func removeCourseList(
        courseIds: [Int]
    ) async throws -> BaseResponseBody<EmptyResponseDTO>
}
