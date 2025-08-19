//
//  PlaceAPI.swift
//  Solply
//
//  Created by 김승원 on 8/3/25.
//

import Foundation

protocol PlaceAPI {
    /// 장소 리스트 조회(필터링)
    func fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool,
        mainTagId: Int?,
        subTagAIdList: [Int]?,
        subTagBIdList: [Int]?
    ) async throws -> BaseResponseBody<PlaceListResponseDTO>
    
    /// 장소 상세 조회(단건)
    func fetchPlaceDetail(
        placeId: Int
    ) async throws -> BaseResponseBody<PlaceDetailResponseDTO>
    
    /// “나만의 장소" 썸네일 리스트 조회
    func fetchPlaceThumbnail() async throws -> BaseResponseBody<PlaceArchiveThumbnailResponseDTO>
    
    /// “나만의 장소" 저장(북마크)
    func submitPlaceBookmark(
        placeId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO>
    
    /// “나만의 장소" 삭제(북마크)
    func removePlaceBookmark(
        placeId: Int
    ) async throws -> BaseResponseBody<EmptyResponseDTO>
    
    /// 선택한 “나만의 장소" 삭제
    func removePlaceList(placeIds: [Int]) async throws -> BaseResponseBody<EmptyResponseDTO>
}

protocol PlaceRecommendAPI {
    /// 추천 장소 조회
    func fetchPlaceRecommend(townId: Int) async throws -> BaseResponseBody<PlaceRecommendResponseDTO>
}
