//
//  ArchiveEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 7/16/25.
//

import Foundation

struct ArchiveEffect {
    private let placeService = PlaceService()
    private let courseService = CourseService()
    
    
    func fetchPlaceThumbnail() async -> ArchiveAction {
        do {
            let response = try await placeService.fetchPlaceThumbnail()
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .placeThumbnailFetched(placeArchiveThumbnails: data.folderThumbnailList)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func fetchCourseThumbnail() async -> ArchiveAction {
        do {
            let response = try await courseService.fetchCourseThumbnail()
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .courseThumbnailFetched(courseArchiveThumbnails: data.folders)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
