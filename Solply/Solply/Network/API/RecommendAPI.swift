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

}
