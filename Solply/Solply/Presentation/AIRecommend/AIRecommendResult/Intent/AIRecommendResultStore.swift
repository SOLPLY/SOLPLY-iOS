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
    
    let cards: [AIRecommendCard]
    
    // MARK: - Initializer
        
    init(cards: [AIRecommendCard]) {
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
