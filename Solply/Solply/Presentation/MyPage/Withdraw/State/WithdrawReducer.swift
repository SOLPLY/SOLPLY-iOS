//
//  WithdrawReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import Foundation

enum WithdrawReducer {
    static func reduce(state: inout WithdrawState, action: WithdrawAction) {
        switch action {
        case .selectWithdrawType(let WithdrawType):
            state.selectedWithdrawType = WithdrawType
            if WithdrawType != .others {   
                state.withdrawContent = ""
            }
        case .updateContent(let text):
            state.withdrawContent = String(text.prefix(200))
        }
    }
}
