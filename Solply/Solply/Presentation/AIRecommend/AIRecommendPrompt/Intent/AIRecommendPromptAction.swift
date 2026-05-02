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
    case aiRecommendButtonTapped(content: SolplyContentType)
    
    // api
    case submitAIPlaceRecommend
    case submitAIPlaceRecommendSuccess
    case submitAIPlaceRecommendFailed(error: NetworkError)
    
    case submitAICourseRecommend
    case submitAICourseRecommendSuccess
    case submitAICourseRecommendFailed(error: NetworkError)
}
