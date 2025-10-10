//
//  PlaceDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

struct PlaceDetailEffect {
    private let courseService: CourseAPI
    private let placeService: PlaceAPI
    
    init(courseService: CourseAPI, placeService: PlaceAPI) {
        self.courseService = courseService
        self.placeService = placeService
    }
}

// MARK: - Functions

extension PlaceDetailEffect {
    func findDirection(
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double,
        destinationName: String
    ) {
        NaverMapRouteHelper.findDirection(
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude,
            destinationName: destinationName
        )
    }
}

// MARK: - CourseAPI

extension PlaceDetailEffect {
    func fetchCourseArchive(placeId: Int?) async -> PlaceDetailAction {
        do {
            let response = try await courseService.fetchCourseArchive(townId: nil, placeId: placeId)
            
            guard let courses = response.data?.courses else { return .errorOccured(error: .responseError) }
            
            return .courseArchiveFetched(courses)
        } catch let error as NetworkError {
            return .errorOccured(error: error)
            
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func submitAddPlace(courseId: Int, placeId: Int) async -> PlaceDetailAction {
        do {
            let response = try await courseService.submitAddPlace(courseId: courseId, placeId: placeId)
            print(response)
            
            return .addPlaceSubmitted
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}

// MARK: - PlaceAPI

extension PlaceDetailEffect {
    func fetchPlaceDetail(placeId: Int) async -> PlaceDetailAction {
        do {
            let response = try await placeService.fetchPlaceDetail(placeId: placeId)
            
            guard let data = response.data else { return .errorOccured(error: .responseError)}
            
            return .placeDetailFetched(data)
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func submitPlaceBookmark(placeId: Int) async -> PlaceDetailAction {
        do {
            let _ = try await placeService.submitPlaceBookmark(placeId: placeId)
            
            return .placeBookmarkSubmitted
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func removePlaceBookmark(placeId: Int) async -> PlaceDetailAction {
        do {
            let _ = try await placeService.removePlaceBookmark(placeId: placeId)
            
            return . placeBookmarkRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
