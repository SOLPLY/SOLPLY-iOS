//
//  PlaceRecommendState.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendState {
    var placeRecommendItems: [PlaceRecommend] = []
    
    var isMainTagBottomSheetPresented: Bool = false
    var isSubTagBottomSheetPresented: Bool = false
    
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
