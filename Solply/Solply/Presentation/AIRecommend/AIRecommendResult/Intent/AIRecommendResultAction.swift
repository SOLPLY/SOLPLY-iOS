//
//  AIRecommendResultAction.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import Foundation

enum AIRecommendResultAction {
    case selectCard(card: AIRecommendCard)
    
    case fetchAIRecommendResults
    case aiRecommendResultsFetched(cards: [AIRecommendCard])
    case fetchAIRecommendResultsFailed(error: NetworkError)
}
