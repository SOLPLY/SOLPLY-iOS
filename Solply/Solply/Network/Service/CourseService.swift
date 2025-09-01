//
//  CourseService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class CourseService: BaseService<CourseTargetType> { }

// MARK: - CourseAPI

extension CourseService: CourseAPI {
    func submitCreateCourseDetail(
        request: CourseCreateRequestDTO
    ) async throws -> BaseResponseBody<CourseCreateResponseDTO> {
        return try await self.request(with: .submitCreateCourseDetail(request: request))
    }
    
    func updateCourseDetail(
        courseId: Int,
        request: CourseUpdateRequestDTO
    ) async throws -> BaseResponseBody<CourseUpdateResponseDTO> {
        return try await self.request(with: .updateCourseDetail(courseId: courseId, request: request))
    }
    
    func submitAddPlace(
        courseId: Int,
        placeId: Int
    ) async throws -> BaseResponseBody<CourseAddPlaceResponseDTO> {
        return try await self.request(with: .submitAddPlace(courseId: courseId, placeId: placeId))
    }
    
    func fetchCourseArchive(
        townId: Int,
        placeId: Int?
    ) async throws -> BaseResponseBody<CourseArchiveResponseDTO> {
        return try await self.request(with: .fetchCourseArchive(townId: townId, placeId: placeId))
    }
    
    func fetchCourseDetail(
        courseId: Int
    ) async throws -> BaseResponseBody<CourseDetailResponseDTO> {
        return try await self.request(with: .fetchCourseDetail(courseId: courseId))
    }
    
    func fetchCourseThumbnail() async throws -> BaseResponseBody<CourseArchiveThumbnailResponseDTO> {
        return try await self.request(with: .fetchCourseThumbnail)
    }
    
    func submitCourseBookmark(
        courseId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .submitCourseBookmark(courseId: courseId))
    }
    
    func removeCourseBookmark(
        courseId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removeCourseBookmark(courseId: courseId))
    }
    
    func removeCourseList(
        courseIds: [Int]
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removeCourseList(courseIds: courseIds))
    }
}
