//
//  PlaceDetail.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation


struct PlaceDetail: Identifiable, Equatable {
    let id = UUID()
    let placeId: Int
    let thumbnailURL: String
    let latitude: Double
    let longitude: Double
    var isFocused: Bool
    var isBookmarked: Bool
    let primaryTag: PlaceCategoryType
    let placeName: String
    let address: String
    let contactNumber: String
    let snsLink: String
    
    static func mockData() -> PlaceDetail {
        return  PlaceDetail(
            placeId: 1,
            thumbnailURL: "",
            latitude: 37.5694,
            longitude: 126.9246,
            isFocused: false,
            isBookmarked: true,
            primaryTag: .book,
            placeName: "장소 이름응응응믕믕믕믕믕응으으으으",
            address: "상세주소오오오오오오오오오오오오오",
            contactNumber: "010-0000-0000",
            snsLink: "sns 주소"
        )
    }
}


extension PlaceDetail {
    init(dto: CourseDetailPlaceDTO) {
        self.placeId = dto.placeId
        self.thumbnailURL = dto.thumbnailUrl ?? ""
        self.latitude = Double(dto.latitude) ?? 0.0
        self.longitude = Double(dto.longitude) ?? 0.0
        self.isFocused = false // 서버에 없음 → 기본값
        self.isBookmarked = dto.isBookmarked
        self.primaryTag = dto.primaryTag
        self.placeName = dto.placeName
        self.address = dto.address
        self.contactNumber = "" // 서버에 없음 → 기본값
        self.snsLink = ""       // 서버에 없음 → 기본값
    }
}
