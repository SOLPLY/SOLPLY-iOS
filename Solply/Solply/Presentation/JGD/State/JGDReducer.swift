//
//  JGDReducer.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

struct JGDReducer {
    static func reduce(state: inout JGDState, action: JGDAction) {
        switch action {
        
        case .fetchTowns:
            break
            
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

        case .fetchTownsFailure(let error):
            print(error)
            
        case .setInitialTownId(let townId):
            state.initialTownId = townId
            
        case .selectTown(let town):
            state.selectedTown = town

            let subTowns = town.subTowns

            if let current = state.currentSelectedSubTown,
               subTowns.contains(current) {
                state.selectedSubTown = current
            } else {
                state.selectedSubTown = subTowns.first
            }

        case .selectSubTown(let subTown):
            state.selectedSubTown = subTown
            state.currentSelectedSubTown = subTown

        case .saveSelection:
            state.isCompleteButtonLoading = true
            
        case .saveSelectionSuccess:
            state.shouldGoBack = true
            state.isCompleteButtonLoading = false
            
        case .saveSelectionFailure(let error):
            state.shouldGoBack = true
            print(error)
        }
    }
}

