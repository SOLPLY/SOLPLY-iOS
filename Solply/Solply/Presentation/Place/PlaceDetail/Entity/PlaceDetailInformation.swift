//
//  PlaceDetailInformation.swift
//  Solply
//
//  Created by 김승원 on 11/2/25.
//

import Foundation

struct PlaceDetailInformation {
    let isBookmarked: Bool
    let primaryTag: MainTagType
    let placeName: String
    let introduction: String
    let imageUrls: [String]
    let address: String
    let contactNumber: String
    let openingHours: String
    let snsLink: [PlaceDetailSnsLink]
    let latitude: Double
    let longitude: Double
    let townId: Int
    let townName: String
    let placeCheckpoints: [String]
}

extension PlaceDetailInformation {
    init(dto: PlaceDetailResponseDTO) {
        self.isBookmarked = dto.isBookmarked
        self.primaryTag = dto.mainTag
        self.placeName = dto.placeName
        self.introduction = dto.introduction
        self.imageUrls = dto.imageInfos.map { $0.url }
        self.address = dto.address
        self.contactNumber = dto.contactNumber ?? ""
        self.openingHours = dto.openingHours.replacingOccurrences(of: "\\n", with: "\n")
        self.snsLink = dto.snsLinks.map { PlaceDetailSnsLink(snsPlatform: $0.snsPlatform, url: $0.url) }
        self.latitude = Double(dto.latitude) ?? 0.0
        self.longitude = Double(dto.longitude) ?? 0.0
        self.townId = dto.townId
        self.townName = dto.townName
        self.placeCheckpoints = dto.placeCheckpoints
    }
    
}
