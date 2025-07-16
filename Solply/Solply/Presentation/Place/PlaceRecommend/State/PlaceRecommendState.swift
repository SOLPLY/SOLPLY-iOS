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
    
    var tempOptionTags: [TempOptionTag] = [
        TempOptionTag(tagId: 1, tagType: "OPTION1", name: "독서", parentId: 1),
        TempOptionTag(tagId: 2, tagType: "OPTION1", name: "작업", parentId: 1),
        TempOptionTag(tagId: 3, tagType: "OPTION1", name: "커피/디저트", parentId: 1),
        TempOptionTag(tagId: 4, tagType: "OPTION1", name: "힐링", parentId: 1),
        TempOptionTag(tagId: 5, tagType: "OPTION2", name: "시그니처 메뉴", parentId: 1),
        TempOptionTag(tagId: 6, tagType: "OPTION2", name: "감성 인테리어", parentId: 1),
        TempOptionTag(tagId: 7, tagType: "OPTION2", name: "콘센트 많음", parentId: 1),
        TempOptionTag(tagId: 8, tagType: "OPTION2", name: "시간 제한 없음", parentId: 1),
        TempOptionTag(tagId: 9, tagType: "OPTION2", name: "채광 좋음", parentId: 1),
        TempOptionTag(tagId: 10, tagType: "OPTION2", name: "창가석 있음", parentId: 1),
        
    ]
    
    var selectedOptionTags: [SelectableOptionTag] = []

}

struct TempOptionTag : Hashable {
    var tagId: Int
    var tagType: String
    var name: String
    var parentId: Int?
}

struct SelectableOptionTag: Identifiable, Hashable {
    let id: Int
    let name: String
    var isSelected: Bool = false

    init(from tag: TempOptionTag) {
        self.id = tag.tagId
        self.name = tag.name
    }
}
