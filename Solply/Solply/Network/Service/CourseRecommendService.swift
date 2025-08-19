//
//  CourseRecommendService.swift
//  Solply
//
//  Created by seozero on 8/19/25.
//

import Foundation

import Moya

final class CourseRecommendService: BaseService<CourseTargetType> { }

extension CourseRecommendService: CourseRecommendAPI {
    func fetchCourseRecommend(townId: Int) async throws -> BaseResponseBody<CourseRecommendResponseDTO> {
        return try await self.request(with: .fetchCourseRecommend(townId: townId))
    }
}
