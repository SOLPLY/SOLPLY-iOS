//
//  AIRecommendEffect.swift
//  Solply
//
//  Created by seozero on 3/20/26.
//

import Foundation

struct AIRecommendEffect {
    private let townService: TownAPI
    
    init(townService: TownAPI) {
        self.townService = townService
    }
    
    func fetchTowns() async -> AIRecommendPromptAction {
        do {
            let response = try await townService.fetchTownList()
            
            guard let data = response.data else {
                return .fetchTownsFailure(error: .responseError)
            }
            
            let towns = data.toEntity()
            
            return .fetchTownsSuccess(townList: towns)
        } catch let error as NetworkError {
            return .fetchTownsFailure(error: error)
        } catch {
            return .fetchTownsFailure(error: .unknownError)
        }
    }
}
