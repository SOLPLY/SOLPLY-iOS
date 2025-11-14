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
    let persona: PersonaType
    let myPlacePreviews: [PlacePreviewResponseDTO]
}

struct SelectedTownDTO: ResponseModelType {
    let townId: Int
    let townName: String
}

struct PlacePreviewResponseDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailImageUrl: String
}
