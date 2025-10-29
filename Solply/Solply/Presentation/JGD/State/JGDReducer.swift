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
            state.errorMessage = nil
            
        case .fetchTownsSuccess(let townList):
            state.townList = townList

            // selectedSubTown 설정
            let subTowns = townList.flatMap { $0.subTowns }
            state.selectedSubTown = subTowns.first { $0.id == state.currentTownId }
            
            // selectedTown 설정
            if let selectedSubTown = state.selectedSubTown {
                state.selectedTown = townList.first{ $0.subTowns.contains(selectedSubTown) }
            }

        case .fetchTownsFailure(let message):
            state.errorMessage = message
            
        case .setCurrentTownId(let townId):
            state.currentTownId = townId
            
        case .selectTown(let town):
            state.selectedTown = town
            state.selectedSubTown = town.subTowns.first

        case .selectSubTown(let subTown):
            state.selectedSubTown = subTown

        case .saveSelection:
            state.errorMessage = nil
            
        case .saveSelectionSuccess:
            break
            
        case .saveSelectionFailure(let message):
            state.errorMessage = message
        }
    }
}

