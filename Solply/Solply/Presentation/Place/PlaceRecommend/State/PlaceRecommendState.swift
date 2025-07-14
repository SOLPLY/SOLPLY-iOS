//
//  PlaceRecommendState.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendState {
    var items: [PlaceRecommendItem] = [
        PlaceRecommendItem(id: 0, title: "장소 0", description: "0번 장소 설명입니다"),
        PlaceRecommendItem(id: 1, title: "장소 1", description: "1번 장소 설명입니다"),
        PlaceRecommendItem(id: 2, title: "장소 2", description: "2번 장소 설명입니다")
    ]
}

struct PlaceRecommendItem: Identifiable, Equatable {
    let id: Int
    let title: String
    let description: String
}
