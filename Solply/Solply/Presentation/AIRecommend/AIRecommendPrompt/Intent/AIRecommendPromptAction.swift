//
//  AIRecommendPromptAction.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

enum AIRecommendPromptAction {
    case selectTab(selectedCategory: SolplyContentType)
    case toggleWritingGuide
    case updatePromptText(String)
    case aiRecommendButtonTapped
    case popularPromptTapped(prompt: String)
    
    // api
    case submitAIPlaceRecommend(townId: Int, prompt: String)
    case submitAIPlaceRecommendSuccess
    case submitAIPlaceRecommendFailed(error: NetworkError)
    
    case submitAICourseRecommend(townId: Int, prompt: String)
    case submitAICourseRecommendSuccess
    case submitAICourseRecommendFailed(error: NetworkError)
}
