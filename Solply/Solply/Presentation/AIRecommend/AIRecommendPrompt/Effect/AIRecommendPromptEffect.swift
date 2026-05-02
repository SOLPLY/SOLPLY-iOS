//
//  AIRecommendPromptEffect.swift
//  Solply
//
//  Created by 김승원 on 4/26/26.
//

import Foundation

struct AIRecommendPromptEffect {
    private let recommendService: RecommendAPI
    
    init(recommendService: RecommendAPI) {
        self.recommendService = recommendService
    }
}

// MARK: - RecommendAPI

extension AIRecommendPromptEffect {
    func submitAIPlaceRecommend(request: AIRecommendRequestDTO) async -> AIRecommendPromptAction {
        do {
            let response = try await recommendService.submitAIPlaceRecommend(request: request)
            
            guard let places = response.data else {
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
            
            guard let courses = response.data else {
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
