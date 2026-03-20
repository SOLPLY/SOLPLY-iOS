//
//  AIRecommendPromptReducer.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

enum AIRecommendPromptReducer {
    static func reduce(
        state: inout AIRecommendPromptState,
        action: AIRecommendPromptAction
    ) {
        switch action {
        case .selectTab(let selectedCategory):
            state.selectedCategory = selectedCategory
            
        case .toggleWritingGuide:
            state.isWritingGuidePresented.toggle()
            
        case .updatePromptText(let text):
            state.isRecommendButtonEnabled = text.count >= 5
            
        case .showTownSelectBottomSheet(let isSheetPresented):
            state.isTownSelectBottomSheetPresented = isSheetPresented
            
        // api
            
        case .fetchTowns:
            state.isTownLoading = true
            
        case .fetchTownsSuccess(let townList):
            state.townList = townList
            
            let subTowns = townList.flatMap { $0.subTowns }
            state.selectedSubTown = subTowns.first { $0.id == state.initialTownId }
            state.currentSelectedSubTown = state.selectedSubTown
            
            if let selectedSubTown = state.selectedSubTown {
                state.selectedTown = townList.first { $0.subTowns.contains(selectedSubTown) }
            } else {
                if let firstTown = townList.first {
                    state.selectedTown = firstTown
                    state.selectedSubTown = firstTown.subTowns.first
                    state.currentSelectedSubTown = state.selectedSubTown
                } else {
                    state.selectedTown = nil
                    state.selectedSubTown = nil
                    state.currentSelectedSubTown = nil
                }
            }
            
            state.isTownLoading = false
            
        case .fetchTownsFailure(let error):
            print(error)
            
        case .setInitialTownId(let townId):
            state.initialTownId = townId
            
        case .selectTown(let town):
            state.selectedTown = town
            
            let subTowns = town.subTowns
            
            if let current = state.currentSelectedSubTown, subTowns.contains(current) {
                state.selectedSubTown = current
            } else {
                state.selectedSubTown = subTowns.first
            }
            
        case .selectSubTown(let subTown):
            state.selectedSubTown = subTown
            state.currentSelectedSubTown = subTown
            
            
        // TODO: - API에 따라 달라질듯
        case .saveSelection:
            break
        case .saveSelectionSuccess:
            break
        case .saveSelectionFailure(let error):
            break
        }
    }
}
