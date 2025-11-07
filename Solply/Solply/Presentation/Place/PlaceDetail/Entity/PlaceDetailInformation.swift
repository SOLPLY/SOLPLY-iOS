//
//  PlaceDetailInformation.swift
//  Solply
//
//  Created by 김승원 on 11/2/25.
//

import Foundation

struct PlaceDetailInformation {
    let isBookmarked: Bool
    let primaryTag: MainTagType
    let placeName: String
    let introduction: String
    let imageUrls: [String]
    let address: String
    let contactNumber: String
    let openingHours: String
    let snsLink: [PlaceDetailSnsLink]
    let latitude: Double
    let longitude: Double
    let placeDefaultId: Int
    let placeType: String
    let townId: Int
    let townName: String
}
