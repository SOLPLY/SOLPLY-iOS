//
//  CourseDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/9/25.
//

import Foundation

struct CourseDetailEffect {
    private let service = CourseService()
    
    func fetchCourseDetail(courseId: Int) async -> CourseDetailAction {
        do {
            let response = try await service.fetchCourseDetail(courseId: courseId)
            
            guard let data = response.data else {
                return .errorOcurred(error: .responseError)
            }
            
            return .courseDetailFetched(courseDetail: data)
            
        } catch let error as NetworkError {
            return .errorOcurred(error: error)
        } catch {
            return .errorOcurred(error: .unknownError)
        }
    }
}
