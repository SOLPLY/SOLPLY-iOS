//
//  AIRecommendResultStore.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import Foundation

@MainActor
final class AIRecommendResultStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = AIRecommendResultState()
    
    let prompt: String
    let cards: [AIRecommendCard]
    
    // MARK: - Initializer
        
    init(prompt: String, cards: [AIRecommendCard]) {
        self.prompt = prompt
        self.cards = cards
    }
    
    // MARK: - dispatch
    
    func dispatch(_ action: AIRecommendResultAction) {
        AIRecommendResultReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
