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

extension PlaceService {
    func submitPlaceBookmark(
        placeId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .submitPlaceBookmark(placeId: placeId))
    }
}

extension PlaceService {
    func removePlaceBookmark(
        placeId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removePlaceBookmark(placeId: placeId))
    }
}

extension PlaceService {
    func fetchPlaceDetail(
        placeId: Int
    ) async throws -> BaseResponseBody<PlaceDetailResponseDTO> {
        return try await self.request(with: .fetchPlaceDetail(placeId: placeId))
    }
}

extension PlaceService {
    func fetchPlaceRecommend(
        townId: Int
    ) async throws -> BaseResponseBody<PlaceRecommendResponseDTO> {
        return try await self.request(with: .fetchPlaceRecommend(townId: townId))
    }
}

extension PlaceService {
    func removePlaceList(placeIds: [Int]) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removePlaceList(placeIds: placeIds))
    }
}

extension PlaceService {
    func fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool = false,
        mainTagId: Int? = nil,
        subTagAIdList: [Int]? = nil,
        subTagBIdList: [Int]? = nil
    ) async throws -> BaseResponseBody<PlaceListResponseDTO> {
        return try await self.request(
            with: .fetchPlaceList(
                townId: townId,
                isBookmarkSearch: isBookmarkSearch,
                mainTagId: mainTagId,
                subTagAIdList: subTagAIdList,
                subTagBIdList: subTagBIdList
            )
        )
    }
        
}
