//
//  PlaceRecommendState.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendState {
    var items: [TempPlaceRecommendItem] = [
        TempPlaceRecommendItem(id: 0, category: .food, title: "장소 0", description: "0번 장소 설명입니다"),
        TempPlaceRecommendItem(id: 1, category: .cafe, title: "장소 1", description: "1번 장소 설명입니다"),
        TempPlaceRecommendItem(id: 2, category: .book, title: "장소 2", description: "2번 장소 설명입니다")
    ]
}
