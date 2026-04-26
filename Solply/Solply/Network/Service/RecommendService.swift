//
//  RecommendService.swift
//  Solply
//
//  Created by seozero on 8/20/25.
//

import Foundation

import Moya

final class RecommendService: BaseService<RecommendTargetType> { }

extension RecommendService: RecommendAPI {
    func fetchPlaceRecommend(townId: Int) async throws -> BaseResponseBody<PlaceRecommendResponseDTO> {
        return try await self.request(with: .fetchPlaceRecommend(townId: townId))
    }
    
    func fetchCourseRecommend(townId: Int) async throws -> BaseResponseBody<CourseRecommendResponseDTO> {
        return try await self.request(with: .fetchCourseRecommend(townId: townId))
    }
    
    func submitAIPlaceRecommend(
        request: AIRecommendRequestDTO
    ) async throws -> BaseResponseBody<AIPlaceRecommendResponseDTO> {
        return try await self.request(with: .submitAIPlaceRecommend(request: request))
    }
    
    func submitAICourseRecommend(
        request: AIRecommendRequestDTO
    ) async throws -> BaseResponseBody<AICourseRecommendResponseDTO> {
        return try await self.request(with: .submitAICourseRecommend(request: request))
    }
}
