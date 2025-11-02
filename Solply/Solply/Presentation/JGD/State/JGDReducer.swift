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

            // selectedSubTown 설정
            let subTowns = townList.flatMap { $0.subTowns }
            state.selectedSubTown = subTowns.first { $0.id == state.initialTownId }
            state.currentSelectedSubTown = state.selectedSubTown
            
            // selectedTown 설정
            if let selectedSubTown = state.selectedSubTown {
                state.selectedTown = townList.first{ $0.subTowns.contains(selectedSubTown) }
            }

        case .fetchTownsFailure(let error):
            print(error)
            
        case .setInitialTownId(let townId):
            state.initialTownId = townId
            
        case .selectTown(let town):
            state.selectedTown = town
            
            let subTowns = town.subTowns
            state.selectedSubTown = subTowns.first { $0 == state.currentSelectedSubTown }

        case .selectSubTown(let subTown):
            state.selectedSubTown = subTown
            state.currentSelectedSubTown = subTown

        case .saveSelection:
            break
            
        case .saveSelectionSuccess:
            state.shouldGoBack = true
            
        case .saveSelectionFailure(let error):
            // TODO: - 선택 실패시 에러 처리 필요(일단 goBack)
            state.shouldGoBack = true
            print(error)
        }
    }
}

