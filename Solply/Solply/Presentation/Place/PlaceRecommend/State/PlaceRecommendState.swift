//
//  PlaceRecommendState.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendState {
    var placeRecommendItems: [TempPlaceRecommendItem] = [
        TempPlaceRecommendItem(id: 0, category: .food, title: "장소 0", description: "0번 장소 설명입니다"),
        TempPlaceRecommendItem(id: 1, category: .cafe, title: "장소 1", description: "1번 장소 설명입니다"),
        TempPlaceRecommendItem(id: 2, category: .book, title: "장소 2", description: "2번 장소 설명입니다")
    ]
    
    var isCategoryBottomSheetPresented: Bool = false
    var selectedCategory: PlaceCategoryType = .all
    
    var isMoreOptionBottomSheetPresented: Bool = false
    
    var moreOptionItems: [TempMoreOptionItem] = [
        TempMoreOptionItem(
            id: 1,
            option1: ["독서", "작업", "커피/디저트", "힐링"],
            option2: ["시그니처 메뉴", "감성 인테리어", "콘센트 많음", "시간 제한 없음", "채광 좋음", "창가석 있음"]
        )
    ]
    
}

struct TempMoreOptionItem {
    var id: PlaceCategoryType.RawValue
    var option1: [String]
    var option2: [String]?
}
