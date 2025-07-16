//
//  CourseDetailStore.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

@MainActor
final class CourseDetailStore: ObservableObject {
    @Published private(set) var state = CourseDetailState()
    private let effect: CourseDetailEffect = CourseDetailEffect()
    
    func dispatch(_ action: CourseDetailAction) {
        CourseDetailReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchCourseDetail(let courseId):
            Task {
                let result = await effect.fetchCourseDetail(courseId: courseId)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
