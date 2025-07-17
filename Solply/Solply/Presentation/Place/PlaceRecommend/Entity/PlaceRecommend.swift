//
//  PlaceRecommend.swift
//  Solply
//
//  Created by seozero on 7/14/25.
//

import Foundation

struct PlaceRecommend: Identifiable, Equatable {
    let id: Int
    let thumbnailUrl: String
    let category: PlaceCategoryType
    let title: String
    let introduction: String
}

extension PlaceRecommend {
    init(dto: PlaceInfoDTO) {
        self.id = dto.placeId
        self.thumbnailUrl = dto.thumbnailImageUrl
        self.category = dto.primaryTag
        self.title = dto.placeName
        self.introduction = dto.introduction
    }
}
