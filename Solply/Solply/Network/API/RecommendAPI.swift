//
//  RecommendAPI.swift
//  Solply
//
//  Created by seozero on 8/20/25.
//

import Foundation

protocol RecommendAPI {
    /// 추천 장소 조회
    func fetchPlaceRecommend(townId: Int) async throws -> BaseResponseBody<PlaceRecommendResponseDTO>
    
    /// 추천 코스 조회
    func fetchCourseRecommend(townId: Int) async throws -> BaseResponseBody<CourseRecommendResponseDTO>

    /// 자연어 기반 장소 추천
    func submitAIPlaceRecommend(query: String, townId: Int) async throws -> BaseResponseBody<AIPlaceRecommendResponseDTO>
    
    /// 자연어 기반 코스 추천
    func submitAICourseRecommend(query: String, townId: Int) async throws -> BaseResponseBody<AICourseRecommendResponseDTO>
}
