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
    private let effect : ArchiveListEffect = ArchiveListEffect()
    
    func dispatch(_ action: ArchiveListAction) {
        ArchiveListReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchCourseList(let townId, let placeId):
            Task {
                let result = await effect.fetchCourseList(townId: townId, placeId: placeId)
                self.dispatch(result)
            }
            
        case .removeCourseList(let CourseIds):
            Task {
                let result = await effect.removeCourseList(CourseIds: CourseIds)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
