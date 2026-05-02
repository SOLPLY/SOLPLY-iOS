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
    case submitAIPlaceRecommend(townId: Int)
    case submitAIPlaceRecommendSuccess
    case submitAIPlaceRecommendFailed(error: NetworkError)
    
    case submitAICourseRecommend(townId: Int)
    case submitAICourseRecommendSuccess
    case submitAICourseRecommendFailed(error: NetworkError)
}
