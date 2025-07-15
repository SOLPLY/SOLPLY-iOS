//
//  UsuallyTownOptionReducer.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

struct UsuallyTownOptionReducer {
    static func reduce(state: inout UsuallyTownOptionState, action: UsuallyTownOptionAction) {
        switch action {
        case .selectOption(let option):
            state.selectedOption = option
        }
    }
}
