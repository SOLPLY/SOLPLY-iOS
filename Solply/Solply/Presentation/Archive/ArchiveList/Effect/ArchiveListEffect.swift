//
//  ArchiveListEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 7/17/25.
//

import Foundation

struct ArchiveListEffect {
    private let placeService: PlaceAPI
    private let courseService: CourseAPI
    
    init(courseService: CourseAPI, placeService: PlaceAPI) {
        self.courseService = courseService
        self.placeService = placeService
    }
    
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
            let _ = try await placeService.removePlaceList(placeIds: placeIds)
            
            return .placeListRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool,
        mainTagId: Int?,
        subTagAIdList: [Int]?,
        subTagBIdList: [Int]?
    ) async -> ArchiveListAction {
        do {
            let response = try await placeService.fetchPlaceList(
                townId: townId,
                isBookmarkSearch: isBookmarkSearch,
                mainTagId: mainTagId,
                subTagAIdList: subTagAIdList,
                subTagBIdList: subTagBIdList
            )
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .placeListFetched(data.places)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
