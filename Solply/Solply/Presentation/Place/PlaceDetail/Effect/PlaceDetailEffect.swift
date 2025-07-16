//
//  PlaceDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

struct PlaceDetailEffect {
    private let courseService = CourseService()
    private let placeService = PlaceService()

    func fetchCourseArchive(townId: Int, placeId: Int?) async -> PlaceDetailAction {
        do {
            let response = try await courseService.fetchCourseArchive(townId: townId, placeId: placeId)
            
            guard let courses = response.data?.courses else { return .errorOccurred(error: .responseError) }
            
            return .courseArchiveFetched(courses)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
            
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
    
    func fetchPlaceDetail(placeId: Int) async -> PlaceDetailAction {
        do {
            let response = try await placeService.fetchPlaceDetail(placeId: placeId)
            
            guard let data = response.data else { return .errorOccurred(error: .responseError)}
            
            return .placeDetailFetched(data)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
}
