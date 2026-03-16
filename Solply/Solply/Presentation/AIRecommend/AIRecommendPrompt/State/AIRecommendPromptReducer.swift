//
//  AIRecommendPromptReducer.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

enum AIRecommendPromptReducer {
    static func reduce(
        state: inout AIRecommendPromptState,
        action: AIRecommendPromptAction
    ) {
        switch action {
        case .toggleAIRecommendBar(let selectedCategory):
            state.selectedCategory = selectedCategory
            
        case .toggleWritingGuide:
            state.isWritingGuidePresented.toggle()
        }
    }
}
