//
//  CourseDetailResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

struct CourseDetailResponseDTO: ResponseModelType {
    let courseId: Int
    let courseName: String
    let introduction: String
    let isBookmarked: Bool
    let places: [PlaceDTO]
}

struct PlaceDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let thumbnailUrl: String
    let primaryTag: PlaceCategoryType
    let address: String
    let isBookmarked: Bool
    let placeOrder: Int
    let latitude: String
    let longitude: String
    let placeType: String
    let placeDefaultId: Int
}
