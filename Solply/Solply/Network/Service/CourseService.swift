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
