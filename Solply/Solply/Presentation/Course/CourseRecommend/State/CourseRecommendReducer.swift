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
            break
            
        case .courseRecommendFetched(let courses):
            state.courses = courses.map { CourseRecommend(dto: $0) }
            
        case .errorOccurred(error: let error):
            print(error)
        }
    }
}
