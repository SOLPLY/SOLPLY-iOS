//
//  ArchiveListEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 7/17/25.
//

import Foundation

struct ArchiveListEffect {
    private let plcaeService = PlaceService()
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
    
    func removeCourseList(courseIds: [Int]) async -> ArchiveListAction {
        do {
            let _ = try await courseService.removeCourseList(courseIds: courseIds)
            
            return .courseListRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func removePlaceList(placeIds: [Int]) async -> ArchiveListAction {
        do {
            let _ = try await plcaeService.removePlaceList(placeIds: placeIds)
            
            return .placeListRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
