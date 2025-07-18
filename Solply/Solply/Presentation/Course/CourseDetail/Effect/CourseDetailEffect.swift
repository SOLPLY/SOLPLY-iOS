//
//  CourseDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/9/25.
//

import UIKit

struct CourseDetailEffect {
    private let service = CourseService()
    private let placeService = PlaceService()
    
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
            
            return .courseBookmarkSubmitted
            
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
    
    func submitPlaceBookmark(placeId: Int) async -> CourseDetailAction {
        do {
            let _ = try await placeService.submitPlaceBookmark(placeId: placeId)
            
            return .placeBookmarkSubmitted
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func removePlaceBookmark(placeId: Int) async -> CourseDetailAction {
        do {
            let _ = try await placeService.removePlaceBookmark(placeId: placeId)
            
            return .placeBookmarkRemoved
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func updateCourseDetail(courseId: Int, request: CourseUpdateRequestDTO) async -> CourseDetailAction {
        do {
            let response = try await service.updateCourseDetail(courseId: courseId, request: request)
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .courseDetailUpdated(updatedCourseId: data.updatedCourseId)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
    func submitCreateCourseDetail(request: CourseCreateRequestDTO) async -> CourseDetailAction {
        do {
            let response = try await service.submitCreateCourseDetail(request: request)
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .createCourseDetailSubmitted(createdCourseId: data.courseId)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
