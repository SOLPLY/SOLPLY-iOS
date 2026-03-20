//
//  AIRecommendPromptStore.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

@MainActor
final class AIRecommendPromptStore: ObservableObject {
    @Published private(set) var state = AIRecommendPromptState()
    
    private let effect = AIRecommendEffect(
        townService: TownService()
    )
    
    func dispatch(_ action: AIRecommendPromptAction) {
        AIRecommendPromptReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchTowns:
            Task {
                let result = await effect.fetchTowns()
                dispatch(result)
            }
            
        default:
            break
        }
    }
}
