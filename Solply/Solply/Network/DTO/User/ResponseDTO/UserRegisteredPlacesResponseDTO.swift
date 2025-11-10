//
//  UserRegisteredPlacesResponseDTO.swift
//  Solply
//
//  Created by sun on 11/9/25.
//

struct UserRegisteredPlacesResponseDTO: ResponseModelType {
    let places: [UserRegisteredPlaceDTO]
}

struct UserRegisteredPlaceDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailImageUrl: String
    let mainTag: String
    let isBookmarked: Bool
}
