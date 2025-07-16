//
//  PlaceRecommendReducer.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

struct PlaceRecommendReducer {
    static func reduce(state: inout PlaceRecommendState, action: PlaceRecommendAction) {
        switch action {
        case .toggleCategoryBottomSheet:
            state.isCategoryBottomSheetPresented = true
        case .dismissCategoryBottomSheet:
            state.isCategoryBottomSheetPresented = false
        case .selectCategory(let category):
            state.selectedCategory = category
            
        case .toggleMoreOptionBottomSheet:
            state.isMoreOptionBottomSheetPresented = true
        case .dismissMoreOptionBottomSheet:
            state.isMoreOptionBottomSheetPresented = false
            
        case .confirmMoreOptionTags(let selectedTags):
            state.selectedOptionTags = selectedTags
        }
    }
}
