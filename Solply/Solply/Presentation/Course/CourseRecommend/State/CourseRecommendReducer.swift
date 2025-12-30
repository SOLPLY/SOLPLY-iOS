//
//  CourseRecommendReducer.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import Foundation

struct CourseRecommendReducer {
    static func reduce(state: inout CourseRecommendState, action: CourseRecommendAction) {
        switch action {
            
        case .fetchCourseRecommend:
            state.isCourseGridLoading = true
            break
            
        case .courseRecommendFetched(let courses):
            state.isCourseGridLoading = false
            state.courses = courses.map { CourseRecommend(dto: $0) }
            
        case .errorOccurred(error: let error):
            state.isCourseGridLoading = false
            print(error)
        }
    }
}
