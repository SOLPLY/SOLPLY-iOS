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
    let mainTag: MainTagType
    let optionTags: [SubTagType]
    let introduction: String
    let imageInfos: [ImageInfoDTO]
    let address: String
    let latitude: String
    let longitude: String
    let contactNumber: String?
    let openingHours: String
    let snsLinks: [SnsLinkDTO]
    let placeCheckpoints: [String]
    let isBookmarked: Bool
    let townId: Int
    let townName: String
    let latestReviews: [ReviewDTO]
}

struct ImageInfoDTO: ResponseModelType {
    let displayOrder: Int
    let url: String?
}

struct SnsLinkDTO: ResponseModelType {
    let snsPlatform: String
    let url: String
}

struct ReviewDTO: ResponseModelType {
    let reviewId: Int
    let userId: Int
    let nickname: String
    let profileImageUrl: String
    let content: String
    let visitedAt: String
    let imageUrls: [String]
}
