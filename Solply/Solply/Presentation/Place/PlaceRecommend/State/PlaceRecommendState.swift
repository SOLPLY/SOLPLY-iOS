//
//  PlaceRecommendState.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendState {
    var isCarouselLoading: Bool = false
    
    var placeRecommendItems: [PlaceRecommend] = []
    
    var isMainTagBottomSheetPresented: Bool = false
    var isSubTagBottomSheetPresented: Bool = false
    
    // 바텀 시트 닫힐 때 값이 변한 게 있는지 없는지, 뭘 선택을 했는지 판단하기 위한 state
    var previousMainTag: MainTagType? = nil
    var selectedMainTag: MainTagType = .all
    var fetchedMainTags: [MainTag] = []
    var fetchedSubTags: [SubTag] = []
    
    var selectedSubTags: [SelectableSubTag] = []

    var fetchedPlaceList: [Place] = []
}

struct SelectableSubTag: Identifiable, Hashable {
    let id: Int
    let name: SubTagType
    let tagType: String
    var isSelected: Bool = false

    init(from tag: SubTag) {
        self.id = tag.id
        self.name = tag.name
        self.tagType = tag.tagType
    }
}
