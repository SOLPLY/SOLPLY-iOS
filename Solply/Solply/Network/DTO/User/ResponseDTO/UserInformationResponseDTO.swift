//
//  UserInformationResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct UserInformationResponseDTO: ResponseModelType {
    let userId: Int
    let nickname: String
    let profileImageUrl: String?
    let selectedTown: SelectedTownDTO
    let persona: String
    let myPlacePreviews: [MyPlacePreviewDTO]
}

struct SelectedTownDTO: ResponseModelType {
    let townId: Int
    let townName: String
}

struct MyPlacePreviewDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailImageUrl: String?
    let mainTag: MainTagType
    let isBookmarked: Bool
}
