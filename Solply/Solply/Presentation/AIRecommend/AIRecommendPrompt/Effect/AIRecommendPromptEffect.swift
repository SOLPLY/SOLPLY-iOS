//
//  AIRecommendPromptEffect.swift
//  Solply
//
//  Created by 김승원 on 4/26/26.
//

import Foundation

struct AIRecommendPromptEffect {
    private let recommendService: RecommendAPI
    private let townService: TownAPI
    
    init(recommendService: RecommendAPI, townService: TownAPI) {
        self.recommendService = recommendService
        self.townService = townService
    }
}

// MARK: - RecommendAPI

extension AIRecommendPromptEffect {
    func submitAIPlaceRecommend(request: AIRecommendRequestDTO) async -> AIRecommendPromptAction {
        do {
            let response = try await recommendService.submitAIPlaceRecommend(request: request)
            
            guard response.data != nil else {
                return .submitAIPlaceRecommendFailed(error: .responseError)
            }
            
            // TODO: - 데이터 매핑 필요
            return .submitAIPlaceRecommendSuccess
            
        } catch let error as NetworkError {
            return .submitAIPlaceRecommendFailed(error: error)
        } catch {
            return .submitAIPlaceRecommendFailed(error: .unknownError)
        }
    }
    
    func submitAICourseRecommend(request: AIRecommendRequestDTO) async -> AIRecommendPromptAction {
        do {
            let response = try await recommendService.submitAICourseRecommend(request: request)
            
            guard response.data != nil else {
                return .submitAICourseRecommendFailed(error: .responseError)
            }
            
            // TODO: - 데이터 매핑 필요
            return .submitAICourseRecommendSuccess
            
        } catch let error as NetworkError {
            return .submitAICourseRecommendFailed(error: error)
        } catch {
            return .submitAICourseRecommendFailed(error: .unknownError)
        }
    }
}

// MARK: - Town API

extension AIRecommendPromptEffect {
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
