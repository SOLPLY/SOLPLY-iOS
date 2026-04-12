//
//  PlaceRecommendState.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendState {
    var isCarouselLoading: Bool = true
    var isPlaceGridLoading: Bool = true
    
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
    var previousTownId: Int = 0
    
    var subTagAIdList: [Int] {
        return selectedSubTags
            .filter { $0.tagType == "OPTION1" && $0.isSelected }
            .map { $0.id }
    }
    
    var subTagBIdList: [Int] {
        return selectedSubTags
            .filter { $0.tagType == "OPTION2" && $0.isSelected }
            .map { $0.id }
    }
    
    var isPlaceRecommendLoading: Bool {
        isCarouselLoading || isPlaceGridLoading
    }
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
