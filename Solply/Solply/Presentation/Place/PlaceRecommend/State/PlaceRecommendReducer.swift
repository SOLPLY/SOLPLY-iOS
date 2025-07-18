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
        case .toggleMainTagBottomSheet:
            state.isMainTagBottomSheetPresented = true
        case .dismissMainTagBottomSheet:
            state.isMainTagBottomSheetPresented = false
        case .selectMainTag(let category):
            state.selectedMainTag = category
            
        case .toggleSubTagBottomSheet:
            state.isSubTagBottomSheetPresented = true
        case .dismissSubTagBottomSheet:
            state.isSubTagBottomSheetPresented = false
            
        case .updateMainTag:
            state.previousMainTag = state.selectedMainTag
            
        case .resetSubTags:
            state.selectedSubTags.removeAll()
            
        case .updateSubTags(let selectedTags):
            state.selectedSubTags = selectedTags
            
            // api
        case .fetchPlaceRecommend:
            break
            
        case .placeRecommendFetched(let placeRecommend):
            state.placeRecommendItems = placeRecommend.prefix(3).map { PlaceRecommend(dto: $0) }
            
        case .fetchMainTags:
            break
            
        case .mainTagsFetched(let mainTags):
            state.fetchedMainTags = mainTags.map { MainTag(dto: $0) }
            
        case .fetchSubTags:
            break
        
        case .subTagsFetched(let subTags):
            state.fetchedSubTags = subTags.map { SubTag(dto: $0) }
            
        case .fetchPlaceList:
            break
            
        case .placeListFetched(let placeList):
            state.fetchedPlaceList = placeList.map { Place(dto: $0) }
            
        case .errorOccurred(error: let error):
            print(error)
        }
    }
}
