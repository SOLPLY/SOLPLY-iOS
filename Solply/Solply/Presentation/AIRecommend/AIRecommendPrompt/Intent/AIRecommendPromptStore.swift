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
            
        case .aiRecommendButtonTapped(let content):
            switch content {
            case .place:
                dispatch(.submitAIPlaceRecommend)
            case .course:
                dispatch(.submitAICourseRecommend)
            }
            
        case .submitAIPlaceRecommend:
            Task {
                let request = AIRecommendRequestDTO(
                    query: "혼자 작업하기 좋은 카페",
                    townId: 2
                )
                let result = await effect.submitAIPlaceRecommend(request: request)
                self.dispatch(result)
            }
            
        case .submitAICourseRecommend:
            Task {
                let request = AIRecommendRequestDTO(
                    query: "자연을 느끼기 좋은 코스",
                    townId: 2
                )
                let result = await effect.submitAICourseRecommend(request: request)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
