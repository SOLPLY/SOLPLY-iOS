//
//  PlaceRecommendResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct PlaceRecommendResponseDTO: ResponseModelType {
    let placeInfos: [PlaceInfoDTO]
}

struct PlaceInfoDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailImageUrl: String?
    let mainTag: String
    let introduction: String
}
