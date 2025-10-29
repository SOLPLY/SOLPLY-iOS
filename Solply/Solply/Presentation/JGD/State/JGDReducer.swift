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
            state.selectedSubTown = subTowns.first { $0.id == state.initialTownId }
            state.currentSelectedSubTown = state.selectedSubTown
            
            // selectedTown 설정
            if let selectedSubTown = state.selectedSubTown {
                state.selectedTown = townList.first{ $0.subTowns.contains(selectedSubTown) }
            }

        case .fetchTownsFailure(let message):
            state.errorMessage = message
            
        case .setInitialTownId(let townId):
            state.initialTownId = townId
            
        case .selectTown(let town):
            state.selectedTown = town
            
            // 타운을 선택하면 최근에 선택했던 subTown과 비교해서
            // 뷰에 표시할지 안 할지 판단
            // 최근 선택한 subTown이 이 Town에 해당하지 않으면 nil로 표시
            // 내가 망원을 선택했었다면, 서울을 택해야 망원이 보이게, 경기를 택하면 nil
            let subTowns = town.subTowns
            state.selectedSubTown = subTowns.first { $0 == state.currentSelectedSubTown }

        case .selectSubTown(let subTown):
            // 서브 타운을 선택하면
            // 바로 업데이트
            state.selectedSubTown = subTown
            state.currentSelectedSubTown = subTown

        case .saveSelection:
            state.errorMessage = nil
            
        case .saveSelectionSuccess:
            break
            
        case .saveSelectionFailure(let message):
            state.errorMessage = message
        }
    }
}

