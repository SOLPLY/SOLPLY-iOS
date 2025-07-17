//
//  FrequentTownReducer.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.


import Foundation

struct FrequentTownReducer {
    static func reduce(state: inout FrequentTownState, action: FrequentTownAction) {
        switch action {
        case .fetchTownList:
            state.errorMessage = nil

        case .fetchSuccess(let selectedTown, let townList):
            state.townList = townList
            state.selectedTown = selectedTown

        case .fetchFailure(let message):
            state.errorMessage = message

        case .selectTown(let town):
            state.selectedTown = town
        }
    }
}
