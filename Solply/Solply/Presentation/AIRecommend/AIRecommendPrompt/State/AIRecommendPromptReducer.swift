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
        case .onAppear(let townId, let townName):
            state.selectedSubTown = SubTown(id: townId, townName: townName)
            
        case .selectTab(let selectedCategory):
            state.selectedCategory = selectedCategory
            
        case .toggleWritingGuide:
            state.isWritingGuidePresented.toggle()
            
        case .updatePromptText(let text):
            state.promptContent = text
            state.isRecommendButtonEnabled = state.promptContent.count >= 5
            
        case .aiRecommendButtonTapped:
            state.isAIRecommendLoading = true
            break
            
        case .popularPromptTapped:
            state.isAIRecommendLoading = true
            
        case .completeTownSelect(let town, let subTown):
            state.selectedTown = town
            state.selectedSubTown = subTown
            state.isTownSelectBottomSheetPresented = false
            
        case .showTownSelectBottomSheet(let isSheetPresented):
            state.isTownSelectBottomSheetPresented = isSheetPresented
            
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
            
        // api
            
        case .submitAIPlaceRecommend:
            break
            
        case .submitAIPlaceRecommendSuccess:
            state.isAIRecommendLoading = false
            
        case .submitAIPlaceRecommendFailed(let error):
            print(error)
            break
            
        case .submitAICourseRecommend:
            break
            
        case .submitAICourseRecommendSuccess:
            state.isAIRecommendLoading = false
            
        case .submitAICourseRecommendFailed(let error):
            print(error)
            break
            
        case .fetchTowns:
            guard state.townList.isEmpty else { return }
            
            state.isTownLoading = true
            
        case .fetchTownsSuccess(let townList):
            
            state.townList = townList
            
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
        }
    }
}
