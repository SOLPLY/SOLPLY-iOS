//
//  AIRecommendPromptState.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

struct AIRecommendPromptState {
    var promptContent: String = ""
    
    var selectedCategory: SolplyContentType = .place
    var isWritingGuidePresented: Bool = false
    // TODO: - 활성화 상태 수정 필요
    var isRecommendButtonEnabled: Bool = false
}
