//
//  CourseRecommendAction.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import Foundation

enum CourseRecommendAction {
    // api
    case fetchCourseRecommend(townId: Int)
    case courseRecommendFetched([CourseDTO])
    case errorOccurred(error: NetworkError)
}
