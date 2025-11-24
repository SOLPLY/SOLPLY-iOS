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
}

extension RegisteredPlace {
    init(dto: UserRegisteredPlaceDTO) {
        id = dto.placeId
        name = dto.placeName
        thumbnail = dto.thumbnailImageUrl
        mainTag = dto.mainTag
        isBookmarked = dto.isBookmarked
    }
}
