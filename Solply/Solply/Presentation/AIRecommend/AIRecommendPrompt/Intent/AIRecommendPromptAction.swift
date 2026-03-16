//
//  AIRecommendPromptAction.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

enum AIRecommendPromptAction {
    case toggleAIRecommendBar(selectedCategory: SolplyContentType)
    case toggleWritingGuide
    case updatePromptText(String)
}
