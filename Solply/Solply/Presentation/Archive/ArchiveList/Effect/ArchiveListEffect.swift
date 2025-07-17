//
//  ArchiveListEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 7/17/25.
//

import Foundation

struct ArchiveListEffect {
    private let courseService = CourseService()
    
    func fetchCourseList(townId: Int, placeId: Int?) async -> ArchiveListAction {
        do {
            let response = try await courseService.fetchCourseArchive(townId: townId, placeId: nil)
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .courseListFetched(courseLists: data.courses)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func removeCourseList(CourseIds: [Int]) async -> ArchiveListAction {
        do {
            let _ = try await courseService.removeCourseList(CourseIds: CourseIds)
            
            return .CourseListRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
