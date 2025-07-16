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
                return .errorOccured(error: .responseError)
            }
            
            return .courseDetailFetched(courseDetail: data)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func submitCourseBookmark(courseId: Int) async -> CourseDetailAction {
        do {
            let _ = try await service.submitCourseBookmark(courseId: courseId)
            
            return .courseBookmarkSubmited
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func removeCourseBookmark(courseId: Int) async -> CourseDetailAction {
        do {
            let _ = try await service.removeCourseBookmark(courseId: courseId)
            
            return .courseBookmarkRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
