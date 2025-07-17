//
//  PlaceDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import UIKit

struct PlaceDetailEffect {
    private let courseService = CourseService()
    private let placeService = PlaceService()
    
    func openNaverMapRoute(
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double,
        destinationName: String
    ) {
        let schemeURLString = "nmap://route/public?" +
        "sname=내 위치&slat=\(startLatitude)&slng=\(startLongitude)" +
        "&dname=\(destinationName)&dlat=\(destinationLatitude)&dlng=\(destinationLongitude)" +
        "&appname=\(Bundle.main.bundleIdentifier ?? "")"
        
        guard let encodedSchemeURLString = schemeURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let schemeURL = URL(string: encodedSchemeURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(schemeURL) {
            UIApplication.shared.open(schemeURL)
        } else {
            if let appStoreURL = URL(string: "https://apps.apple.com/app/id311867728") {
                UIApplication.shared.open(appStoreURL)
            }
        }
    }

    func fetchCourseArchive(townId: Int, placeId: Int?) async -> PlaceDetailAction {
        do {
            let response = try await courseService.fetchCourseArchive(townId: townId, placeId: placeId)
            
            guard let courses = response.data?.courses else { return .errorOccured(error: .responseError) }
            
            return .courseArchiveFetched(courses)
        } catch let error as NetworkError {
            return .errorOccured(error: error)
            
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
    
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
            
            return .placeBookmarkSubmited
            
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
