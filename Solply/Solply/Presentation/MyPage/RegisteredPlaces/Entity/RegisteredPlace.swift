//
//  RegisteredPlace.swift
//  Solply
//
//  Created by seozero on 11/19/25.
//

struct RegisteredPlace: Equatable, Identifiable {
    let id: Int
    let name: String
    let thumbnail: String
    let mainTag: MainTagType
    let isBookmarked: Bool
    let townId: Int
}

extension RegisteredPlace {
    init(dto: UserRegisteredPlaceDTO) {
        id = dto.placeId
        name = dto.placeName
        thumbnail = dto.thumbnailImageUrl
        mainTag = dto.primaryTag
        isBookmarked = dto.isBookmarked
        townId = dto.townId
    }
}
