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

            if let firstTown = townList.first {
                state.selectedTown = firstTown
                state.selectedSubTown = firstTown.subTowns.first
            }

        case .fetchTownsFailure(let message):
            state.errorMessage = message
            
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

