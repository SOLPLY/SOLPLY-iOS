//
//  CourseRecommendStore.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import Foundation

@MainActor
final class CourseRecommendStore: ObservableObject {
    @Published private(set) var state = CourseRecommendState()
    private let effect = CourseRecommendEffect(
        recommendService: RecommendService()
    )
    
    func dispatch(_ action: CourseRecommendAction) {
        CourseRecommendReducer.reduce(state: &state, action: action)

        switch action {
        case .fetchCourseRecommend(let townId):
            guard townId != 0 else { return }
            
            Task {
                let result = await effect.fetchCourseRecommend(townId: townId)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
