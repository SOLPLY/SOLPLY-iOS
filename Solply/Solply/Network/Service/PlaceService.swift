//
//  PlaceService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class PlaceService: BaseService<PlaceTargetType> { }

// MARK: - PlaceAPI

extension PlaceService: PlaceAPI {
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
    
    func fetchPlaceDetail(
        placeId: Int
    ) async throws -> BaseResponseBody<PlaceDetailResponseDTO> {
        return try await self.request(with: .fetchPlaceDetail(placeId: placeId))
    }
    
    func fetchPlaceThumbnail() async throws -> BaseResponseBody<PlaceArchiveThumbnailResponseDTO> {
        return try await self.request(with: .fetchPlaceThumbnail)
    }
    
    func submitPlaceBookmark(
        placeId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .submitPlaceBookmark(placeId: placeId))
    }
    
    func removePlaceBookmark(
        placeId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removePlaceBookmark(placeId: placeId))
    }
    
    func removePlaceList(placeIds: [Int]) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .removePlaceList(placeIds: placeIds))
    }
    
    func searchPlace(
        placeName: String
    ) async throws -> BaseResponseBody<PlaceSearchResponseDTO> {
        return try await self.request(with: .searchPlace(placeName: placeName))
    }
    
    func submitReports(
        placeId: Int,
        request: ReportsRequestDTO
    ) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .submitReports(placeId: placeId, request: request))
    }
    
    func submitRegister(
        request: RegisterRequestDTO
    ) async throws -> BaseResponseBody<RegisterResponseDTO> {
        return try await self.request(with: .submitRegister(request: request))
    }
}
