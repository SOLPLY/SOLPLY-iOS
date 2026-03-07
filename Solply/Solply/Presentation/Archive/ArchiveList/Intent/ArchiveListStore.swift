//
//  ArchiveListStore.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

@MainActor
final class ArchiveListStore: ObservableObject {
    @Published private(set) var state = ArchiveListState()
    private let effect : ArchiveListEffect = ArchiveListEffect(
        courseService: CourseService(),
        placeService: PlaceService()
    )
    
    func dispatch(_ action: ArchiveListAction) {
        ArchiveListReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchCourseList(let townId, let placeId):
            Task {
                let result = await effect.fetchCourseList(townId: townId, placeId: placeId)
                self.dispatch(result)
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
            
        case .removeCourseList(let courseIds):
            Task {
                let result = await effect.removeCourseList(courseIds: courseIds)
                self.dispatch(result)
            }
            
            
        case .removePlaceList(let placeIds):
            Task {
                let result = await effect.removePlaceList(placeIds: placeIds)
                self.dispatch(result)
            }
            
        case .placeListRemoved(let removedCount):
            AmplitudeManager.shared.track(.completeRemoveCollectionItems(removeCount: removedCount))
            
        case .courseListRemoved(let removedCount):
            AmplitudeManager.shared.track(.completeRemoveCollectionItems(removeCount: removedCount))
            
        default:
            break
        }
    }
}
