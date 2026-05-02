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
        case .selectTab(let selectedCategory):
            state.selectedCategory = selectedCategory
            
        case .toggleWritingGuide:
            state.isWritingGuidePresented.toggle()
            
        case .updatePromptText(let text):
            state.isRecommendButtonEnabled = text.count >= 5
            
        case .aiRecommendButtonTapped:
            break
            
            
        case .submitAIPlaceRecommend:
            break
            
        case .submitAIPlaceRecommendSuccess:
            break
            
        case .submitAIPlaceRecommendFailed(let error):
            print(error)
            break
            
        case .submitAICourseRecommend:
            break
            
        case .submitAICourseRecommendSuccess:
            break
            
        case .submitAICourseRecommendFailed(let error):
            print(error)
            break
            
        }
    }
}
