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
        case .onAppear(let townId):
            print("previous: \(state.previousTownId), current: \(townId)")
            // TODO: - 초기 TownId값이 0인 것 때문에 임시로 if문 추가
            // 2.0.0에서는 지워야 함
            if state.previousTownId == 0 {
                state.previousTownId = townId
            }
            let townChanged = state.previousTownId != townId
            state.previousTownId = townId
            
            
            if townChanged {
                print("동네 변경됨)")
                state.selectedMainTag = .all
                state.selectedSubTags = []
            }
            
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
            state.placeRecommendItems = []
            break
            
        case .placeRecommendFetched(let placeRecommend):
            dump(state.placeRecommendItems)
            state.placeRecommendItems = placeRecommend.prefix(3).map { PlaceRecommend(dto: $0) }
            state.isCarouselLoading = false
            
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
            state.fetchedPlaceList = []
            break
            
        case .placeListFetched(let placeList):
            state.fetchedPlaceList = placeList.map { Place(dto: $0) }
            state.isPlaceGridLoading = false
            
        case .fetchPlaceListFailed(let error):
            state.isPlaceGridLoading = true
            print(error)
            state.fetchedPlaceList = []
            
        case .errorOccurred(error: let error):
            print(error)
        }
    }
}
