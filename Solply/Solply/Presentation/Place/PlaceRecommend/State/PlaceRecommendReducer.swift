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
        case .resetTags:
            state.selectedMainTag = .all
            state.selectedSubTags = []
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
            state.isCarouselLoading = true
            break
            
        case .placeRecommendFetched(let placeRecommend):
            // TODO: - 추천 장소 없을 때 어떻게 표시할지 논의 필요
            // 일단 스켈레톤뷰 노출
            state.isCarouselLoading = true
            state.placeRecommendItems = placeRecommend.prefix(3).map { PlaceRecommend(dto: $0) }
            
        case .fetchPlaceRecommendFailed(let error):
            state.isCarouselLoading = true
            print(error)
            break
            
        case .fetchMainTags:
            break
            
        case .mainTagsFetched(let mainTags):
            state.fetchedMainTags = mainTags.map { MainTag(dto: $0) }
            
        case .fetchSubTags:
            break
        
        case .subTagsFetched(let subTags):
            state.fetchedSubTags = subTags.map { SubTag(dto: $0) }
            
        case .fetchPlaceList:
            state.isPlaceGridLoading = true
            break
            
        case .placeListFetched(let placeList):
            state.isPlaceGridLoading = false
            state.fetchedPlaceList = placeList.map { Place(dto: $0) }
            
        case .fetchPlaceListFailed(let error):
            state.isPlaceGridLoading = true
            print(error)
            state.fetchedPlaceList = []
            
        case .errorOccurred(error: let error):
            print(error)
        }
    }
}
