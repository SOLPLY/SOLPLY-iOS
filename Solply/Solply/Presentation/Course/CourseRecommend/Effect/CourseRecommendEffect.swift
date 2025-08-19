//
//  CourseRecommendEffect.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct CourseRecommendEffect {
    private let courseRecommendService = CourseRecommendService()
    
    func fetchCourseRecommend(townId: Int) async -> CourseRecommendAction {
        do {
            let response = try await courseRecommendService.fetchCourseRecommend(townId: townId)
            
            guard let data = response.data else {
                return .errorOccurred(error: .responseError)
            }
            return .courseRecommendFetched(data.courses)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
}
