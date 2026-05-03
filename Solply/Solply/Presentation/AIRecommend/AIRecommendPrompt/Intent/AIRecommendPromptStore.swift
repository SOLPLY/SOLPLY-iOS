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
        self.effect = AIRecommendPromptEffect(
            recommendService: RecommendService(),
            townService: TownService()
        )
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: AIRecommendPromptAction) {
        AIRecommendPromptReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .aiRecommendButtonTapped:
            guard let townId = state.selectedSubTown?.id else { return }
            
            switch state.selectedCategory {
            case .place:
                dispatch(.submitAIPlaceRecommend(townId: townId, prompt: state.promptContent))
            case .course:
                dispatch(.submitAICourseRecommend(townId: townId, prompt: state.promptContent))
            }

        case .popularPromptTapped(let prompt):
            guard let townId = state.selectedSubTown?.id else { return }
            
            switch state.selectedCategory {
            case .place:
                dispatch(.submitAIPlaceRecommend(townId: townId, prompt: prompt))
            case .course:
                dispatch(.submitAICourseRecommend(townId: townId, prompt: prompt))
            }
            
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
            
        case .fetchTowns:
            guard state.townList.isEmpty else { return }
            
            Task {
                let result = await effect.fetchTowns()
                dispatch(result)
            }
            
        default:
            break
        }
    }
}
