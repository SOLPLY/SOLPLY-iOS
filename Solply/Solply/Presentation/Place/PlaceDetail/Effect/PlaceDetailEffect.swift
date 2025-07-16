//
//  PlaceDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

struct PlaceDetailEffect {
    private let courseService: PlaceDetailAPI
    
    // TODO: 추후 plaecService만들면 주입
//    private let placeService: PlaceDetailAPI

//    init(courseService: PlaceDetailAPI, placeService: PlaceDetailAPI) {
//        self.courseService = courseService
//        self.placeService = placeService
//    }
    
    init(courseService: PlaceDetailAPI) {
        self.courseService = courseService
    }
    
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
}
