//
//  AIPlaceRecommendResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 4/26/26.
//

import Foundation

struct AIPlaceRecommendResponseDTO: ResponseModelType {
    let places: [AIRecommendedPlace]
}

struct AIRecommendedPlace: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailImageUrl: String
    let mainTag: String
    let optionTags: [String]
    let townName: String
    let reason: String
}
