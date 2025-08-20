//
//  PlaceRecommendStore.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

@MainActor
final class PlaceRecommendStore: ObservableObject {
    @Published private(set) var state = PlaceRecommendState()
    private let effect = PlaceRecommendEffect(
        placeService: PlaceService(),
        recommendService: RecommendService()
    )
    
    func dispatch(_ action: PlaceRecommendAction, completion: (() -> Void)? = nil) {
        PlaceRecommendReducer.reduce(state: &state, action: action)

        switch action {
        case .fetchPlaceRecommend(let townId):
            Task {
                let result = await effect.fetchPlaceRecommend(townId: townId)
                self.dispatch(result)
            }
            
        case .fetchMainTags:
            Task {
                let result = await effect.fetchMainTags()
                self.dispatch(result)
            }
            
        case .fetchSubTags(let parentId):
            Task {
                let result = await effect.fetchSubTags(parentId: parentId)
                self.dispatch(result)
                completion?()
            }
            
        case .fetchPlaceList(
            let townId,
            let isBookmarkSearch,
            let mainTagId,
            let subTagAIdList,
            let subTagBIdList
        ):
            Task {
                let result = await effect.fetchPlaceList(
                    townId: townId,
                    isBookmarkSearch: isBookmarkSearch,
                    mainTagId: mainTagId,
                    subTagAIdList: subTagAIdList,
                    subTagBIdList: subTagBIdList
                )
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
