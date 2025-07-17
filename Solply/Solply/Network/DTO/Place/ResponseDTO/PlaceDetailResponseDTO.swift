//
//  PlaceDetailResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/17/25.
//

import Foundation

struct PlaceDetailResponseDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let primaryTag: PlaceCategoryType
    let introduction: String
    let imageInfos: [ImageInfoDTO]
    let address: String
    let latitude: String
    let longitude: String
    let contactNumber: String?
    let openingHours: String
    let snsLinks: [SnsLinkDTO]
    let isBookmarked: Bool
    let placeType: String
    let placeDefaultId: Int
}

struct ImageInfoDTO: ResponseModelType {
    let displayOrder: Int
    let url: String
}

struct SnsLinkDTO: ResponseModelType {
    let snsPlatform: String
    let url: String
}
