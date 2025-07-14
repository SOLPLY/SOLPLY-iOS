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
            state.isCategoryBottomSheetPresented.toggle()
        case .dismissCategoryBottomSheet:
            state.isCategoryBottomSheetPresented = false
        }
    }
}
