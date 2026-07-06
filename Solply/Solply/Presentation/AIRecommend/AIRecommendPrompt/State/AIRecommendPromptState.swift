//
//  AIRecommendPromptState.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

struct AIRecommendPromptState {
    var isAIRecommendLoading: Bool = false
    
    var promptContent: String = ""
    
    var placeExamplePhrases: [String] = []
    var courseExamplePhrases: [String] = []
    
    var selectedCategory: SolplyContentType = .place
    var isWritingGuidePresented: Bool = false
    var isTownSelectBottomSheetPresented: Bool = false
    var isRecommendButtonEnabled: Bool = false
    var shouldNavigate: Bool = false
    var aiRecommendResult: [AIRecommendCard] = []
    
    // MARK: - TownSelectBottomSheet
    
    var isTownLoading: Bool = false
    var isCompleteButtonLoading: Bool = false
    
    var currentSelectedSubTown: SubTown? = nil
    
    var townList: [Town] = []
    var selectedTown: Town? = nil
    var selectedSubTown: SubTown? = nil
    
    var selectTownHeader: String {
        guard let selectedSubTown else { return "" }
        
        let isAllSelected = selectedSubTown.id == selectedTown?.id
        
        return isAllSelected ? (selectedTown?.townName ?? "") : selectedSubTown.townName
    }
    
    var examplePhrases: [String] {
        switch selectedCategory {
        case .place: return placeExamplePhrases
        case .course: return courseExamplePhrases
        }
    }
}
