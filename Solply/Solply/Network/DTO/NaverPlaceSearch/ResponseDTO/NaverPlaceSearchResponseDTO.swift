//
//  NaverPlaceSearchResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 10/30/25.
//

import Foundation

struct NaverPlaceSearchResponseDTO: ResponseModelType {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [NaverPlaceItem]
}

struct NaverPlaceItem: ResponseModelType {
    let title: String
    let link: String
    let category: String
    let description: String
    let telephone: String?
    let address: String
    let roadAddress: String
    let mapx: String
    let mapy: String
}
