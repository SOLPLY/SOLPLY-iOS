//
//  PlaceRecommendEffect.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct PlaceRecommendEffect {
    private let placeService = PlaceService()
    
    func fetchPlaceRecommend(townId: Int) async -> PlaceRecommendAction {
        do {
            let response = try await placeService.fetchPlaceRecommend(townId: townId)
            
            guard let data = response.data else {
                return .errorOccurred(error: .responseError)
            }
            return .placeRecommendFetched(data.placeInfos)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
}
