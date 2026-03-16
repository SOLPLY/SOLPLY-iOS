//
//  AIRecommendResultReducer.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import Foundation

enum AIRecommendResultReducer {
    static func reduce(state: inout AIRecommendResultState, action: AIRecommendResultAction) {
        switch action {
        case .selectPlaceCard:
            break
            
        case .selectCourseCard:
            break
            
        case .fetchAIRecommendResults:
            // TODO: - 서버 작업 후 지울 예정임니댜!!
            state.cards = AIRecommendCard.mockData
            
        case .aiRecommendResultsFetched(let cards):
            state.cards = cards
            
        case .fetchAIRecommendResultsFailed:
            break
        }
    }
}
