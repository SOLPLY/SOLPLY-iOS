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
    
    // MARK: - Initializer
        
    // TODO: - API 연동할 때 Effect 추가하겟슴니다!!
    
    // MARK: - dispatch
    
    func dispatch(_ action: AIRecommendResultAction) {
        AIRecommendResultReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
