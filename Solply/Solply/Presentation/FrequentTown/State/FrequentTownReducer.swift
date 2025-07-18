//
//  FrequentTownReducer.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.


import Foundation

struct FrequentTownReducer {
    static func reduce(state: inout FrequentTownState, action: FrequentTownAction) {
        switch action {
        case .fetchTown:
            state.errorMessage = nil

        case .fetchSuccess(let selectedTown, let townList):
            state.selectedTown = selectedTown
            state.townList = townList

        case .fetchFailure(let message):
            state.errorMessage = message

        case .selectTown(let town):
            state.selectedTown = town
            print("🏠 사용자가 선택한 동네: \(town.name) (id: \(town.id))")

        case .saveTown:
            state.isSaving = true
            state.errorMessage = nil

        case .saveSuccess:
            state.isSaving = false
            print("✅ 동네 저장 성공")

        case .saveFailure(let message):
            state.isSaving = false
            state.errorMessage = message
        }
    }
}
