//
//  AIRecommendPromptStore.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

@MainActor
final class AIRecommendPromptStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = AIRecommendPromptState()
    private let effect: AIRecommendPromptEffect
    
    // MARK: - Initializer
    
    init() {
        self.effect = AIRecommendPromptEffect(recommendService: RecommendService())
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: AIRecommendPromptAction) {
        AIRecommendPromptReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .aiRecommendButtonTapped:
            // TODO: - townId 연동 필요
            switch state.selectedCategory {
            case .place:
                dispatch(.submitAIPlaceRecommend(townId: 2, prompt: state.promptContent))
            case .course:
                dispatch(.submitAICourseRecommend(townId: 2, prompt: state.promptContent))
            }

        case .popularPromptTapped(let prompt):
            switch state.selectedCategory {
            case .place:
                dispatch(.submitAIPlaceRecommend(townId: 2, prompt: prompt))
            case .course:
                dispatch(.submitAICourseRecommend(townId: 2, prompt: prompt))
            }
            
            //
            
        case .submitAIPlaceRecommend(let townId, let prompt):
            Task {
                let request = AIRecommendRequestDTO(query: prompt, townId: townId)
                let result = await effect.submitAIPlaceRecommend(request: request)
                self.dispatch(result)
            }
            
        case .submitAICourseRecommend(let townId, let prompt):
            Task {
                let request = AIRecommendRequestDTO(query: prompt, townId: townId)
                let result = await effect.submitAICourseRecommend(request: request)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
