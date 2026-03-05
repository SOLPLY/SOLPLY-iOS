//
//  Place.swift
//  Solply
//
//  Created by seozero on 7/18/25.
//

import Foundation

struct Place: Identifiable {
    let placeId: Int
    let placeName: String
    let thumbnailUrl: String?
    let mainTag: MainTagType
    let isBookmarked: Bool
    
    var id: Int { placeId }
}

extension Place {
    init(dto: PlaceDTO) {
        self.placeId = dto.placeId
        self.placeName = dto.placeName
        self.thumbnailUrl = dto.thumbnailImageUrl
        self.mainTag = MainTagType(rawValue: dto.primaryTag) ?? .book
        self.isBookmarked = dto.isBookmarked
    }
}
