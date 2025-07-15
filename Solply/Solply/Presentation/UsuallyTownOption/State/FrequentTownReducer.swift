//
//  FrequentTownReducer.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

struct FrequentTownReducer {
    static func reduce(state: inout FrequentTownState, action: FrequentTownAction) {
        switch action {
        case .selectOption(let option):
            state.selectedOption = option
        }
    }
}
