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

        case .fetchTopTowns:
            state.errorMessage = nil

        case .fetchTopTownsSuccess(let topTownList):
            state.topTownList = topTownList

            if let firstTop = topTownList.first {
                state.selectedTopTown = firstTop
                state.selectedSubTown = firstTop.subTowns.first
            }

        case .fetchTopTownsFailure(let message):
            state.errorMessage = message

        case .selectTopTown(let topTown):
            state.selectedTopTown = topTown
            state.selectedSubTown = topTown.subTowns.first

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
