//
//  PlaceListResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/18/25.
//

import Foundation

struct PlaceListResponseDTO: ResponseModelType {
    let places: [PlaceDTO]
}

struct PlaceDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailImageUrl: String
    let primaryTag: MainTagType
    let isBookmarked: Bool
}
