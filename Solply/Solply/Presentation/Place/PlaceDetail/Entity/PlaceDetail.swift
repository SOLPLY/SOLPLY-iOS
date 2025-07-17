//
//  PlaceDetail.swift
//  Solply
//
//  Created by 김승원 on 7/17/25.
//

import Foundation

struct PlaceDetail: Identifiable, Equatable {
    let id = UUID()
    let placeId: Int
    let placeName: String
    let primaryTag: MainTagType
    let introduction: String
    let imageInfos: [PlaceDetailImageInfo]
    let address: String
    let latitude: Double
    let longitude: Double
    let contactNumber: String
    let openingHours: String
    let snsLink: [PlaceDetailSnsLink]
    var isBookmarked: Bool
    let placeDefaultId: Int
    let placeType: String
    var isFocused: Bool
}

struct PlaceDetailImageInfo: Equatable {
    let displayOrder: Int
    let url: String
}

struct PlaceDetailSnsLink: Equatable {
    let snsPlatform: String
    let url: String
}
