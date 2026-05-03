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
    
    /// 장소 검색
    func searchPlace(placeName: String) async throws -> BaseResponseBody<PlaceSearchResponseDTO>
    
    /// 잘못된 정보 제보
    func submitReports(
        placeId: Int,
        request: ReportsRequestDTO
    ) async throws -> BaseResponseBody<EmptyResponseDTO>
    
    /// 장소 등록 요청
    func submitRegister(request: RegisterRequestDTO) async throws -> BaseResponseBody<RegisterResponseDTO>
    
    /// 장소 리뷰(기록) 작성
    func submitPlaceRecordWrite(request: PlaceRecordWriteRequestDTO) async throws -> BaseResponseBody<EmptyResponseDTO>
    
    /// 장소 리뷰(기록) 리스트 조회
    func fetchPlaceRecordList(placeId: Int) async throws -> BaseResponseBody<PlaceRecordListResponseDTO>
}
