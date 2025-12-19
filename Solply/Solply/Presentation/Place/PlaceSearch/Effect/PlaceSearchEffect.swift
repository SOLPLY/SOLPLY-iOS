//
//  PlaceSearchEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 9/25/25.
//

import Foundation

struct PlaceSearchEffect {
    private let placeService: PlaceAPI
    
    init(placeService: PlaceAPI) {
        self.placeService = placeService
    }
    
    func searchPlace(placeName: String) async -> PlaceSearchAction {
        do {
            let response = try await placeService.searchPlace(placeName: placeName)
            
            guard let data = response.data else {
                return .searchPlaceFailed(error: .responseError)
            }
            
            return .searchPlaceSuccess(places: data.places)
        } catch let error as NetworkError {
            return .searchPlaceFailed(error: error)
        } catch {
            return .searchPlaceFailed(error: .unknownError)
        }
    }
}
