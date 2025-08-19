//
//  PlaceRecommendService.swift
//  Solply
//
//  Created by seozero on 8/19/25.
//

import Foundation

import Moya

final class PlaceRecommendService: BaseService<PlaceTargetType> { }

extension PlaceRecommendService: PlaceRecommendAPI {
    func fetchPlaceRecommend(
        townId: Int
    ) async throws -> BaseResponseBody<PlaceRecommendResponseDTO> {
        return try await self.request(with: .fetchPlaceRecommend(townId: townId))
    }
}
