//
//  CourseService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class CourseService: BaseService<CourseTargetType> { }

extension CourseService: PlaceDetailAPI {
    func fetchCourseArchive(
        townId: Int,
        placeId: Int?
    ) async throws -> BaseResponseBody<CourseArchiveResponseDTO> {
        return try await self.request(with: .fetchCourseArchive(townId: townId, placeId: placeId))
    }
}

extension CourseService {
    func fetchCourseDetail(courseId: Int) async throws -> BaseResponseBody<CourseDetailResponseDTO> {
        return try await self.request(with: .fetchCourseDetail(courseId: courseId))
    }
}

extension CourseService {
    func submitCourseBookmark(courseId: Int) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .submitCourseBookmark(courseId: courseId))
    }
}

extension CourseService {
    func removeCourseBookmark(courseId: Int) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removeCourseBookmark(courseId: courseId))
    }
}

extension CourseService {
    func fetchCourseThumbnail() async throws -> BaseResponseBody<CourseArchiveThumbnailResponseDTO> {
        return try await self.request(with: .fetchCourseThumbnail)
    }
}

extension CourseService {
    func fetchCourseRecommend(townId: Int) async throws -> BaseResponseBody<CourseRecommendResponseDTO> {
        return try await self.request(with: .fetchCourseRecommend(townId: townId))
    }
}

extension CourseService {
    func removeCourseList(courseIds: [Int]) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removeCourseList(courseIds: courseIds))
    }
}

extension CourseService {
    func submitAddPlace(
        courseId: Int,
        placeId: Int
    ) async throws -> BaseResponseBody<CourseAddPlaceResponseDTO> {
        return try await self.request(with: .submitAddPlace(courseId: courseId, placeId: placeId))
    }
}
