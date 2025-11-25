//
//  UserPlace.swift
//  Solply
//
//  Created by sun on 11/9/25.
//

struct UserPlace: Hashable {
    let id: Int
    let name: String
    let thumbnail: String
    let mainTag: MainTagType
    let isBookmarked: Bool
}

extension UserPlace {
    init(dto: UserRegisteredPlaceDTO) {
        id = dto.placeId
        name = dto.placeName
        thumbnail = dto.thumbnailImageUrl
        mainTag = dto.mainTag
        isBookmarked = dto.isBookmarked
    }
    
    init(previewDTO: MyPlacePreviewDTO) {
        id = previewDTO.placeId
        name = previewDTO.placeName
        thumbnail = previewDTO.thumbnailImageUrl ?? ""
        mainTag = previewDTO.mainTag
        isBookmarked = previewDTO.isBookmarked
    }
}
