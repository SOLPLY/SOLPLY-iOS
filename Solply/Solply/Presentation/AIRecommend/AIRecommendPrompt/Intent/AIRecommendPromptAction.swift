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
    case showTownSelectBottomSheet(isSheetPresented: Bool)
    
    // MARK: - TownSelectBottomSheet
    
    case fetchTowns
    case fetchTownsSuccess(townList: [Town])
    case fetchTownsFailure(error: NetworkError)
    
    case setInitialTownId(townId: Int)
    
    case selectTown(Town)
    case selectSubTown(SubTown)
    
    case saveSelection
    case saveSelectionSuccess
    case saveSelectionFailure(error: NetworkError)
}
