//
//  AIRecommendPromptState.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

struct AIRecommendPromptState {
    var selectedCategory: SolplyContentType = .place
    var isWritingGuidePresented: Bool = false
    var isRecommendButtonEnabled: Bool = false
    var isTownSelectBottomSheetPresented: Bool = false
    
    // MARK: - TownSelectBottomSheet
    
    var isTownLoading: Bool = false
    var isCompleteButtonLoading: Bool = false
    
    var initialTownId: Int = 0
    var currentSelectedSubTown: SubTown? = nil
    
    var townList: [Town] = []
    var selectedTown: Town? = nil
    var selectedSubTown: SubTown? = nil
    
    
}
