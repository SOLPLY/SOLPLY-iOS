//
//  PlaceService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class PlaceService: BaseService<PlaceTargetType> { }

extension PlaceService {
    func fetchPlaceThumbnail() async throws -> BaseResponseBody<PlaceArchiveThumbnailResponseDTO> {
        return try await self.request(with: .fetchPlaceThumbnail)
    }
}

