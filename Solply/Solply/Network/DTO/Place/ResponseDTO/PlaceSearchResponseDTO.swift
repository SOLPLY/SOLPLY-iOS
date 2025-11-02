//
//  PlaceSearchResponseDTO.swift
//  Solply
//
//  Created by LEESOOYONG on 9/24/25.
//

import Foundation

struct PlaceSearchResponseDTO: ResponseModelType {
    let places: [PlaceSearchDTO]
}

struct PlaceSearchDTO: ResponseModelType {
    let placeId: Int
    let townId: Int
    let placeName: String
    let thumbnailImageUrl: String
    let primaryTag: MainTagType
    let address: String
}
