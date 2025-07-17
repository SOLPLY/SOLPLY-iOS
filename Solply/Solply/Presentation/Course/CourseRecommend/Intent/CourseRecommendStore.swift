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
    private let effect = CourseRecommendEffect()
    
    func dispatch(_ action: CourseRecommendAction) {
        CourseRecommendReducer.reduce(state: &state, action: action)

        switch action {
        case .fetchCourseRecommend(let townId):
            Task {
                let result = await effect.fetchCourseRecommend(townId: townId)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
