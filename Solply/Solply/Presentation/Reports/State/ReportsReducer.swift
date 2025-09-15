//
//  ReportsReducer.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

enum ReportsReducer {
    static func reduce(state: inout ReportsState, action: ReportsAction) {
        switch action {
        case .selectReportsType(let reportsType):
            state.selectedReportsType = reportsType
            
        case .changeReportsStep:
            switch state.reportsStep {
            case .ReportsSelect:
                state.reportsStep = .ReportsDetail
            case .ReportsDetail:
                state.reportsStep = .ReportsComplete
            default:
                break
            }
            
        case .editReportsContent(let reportsContent):
            state.reportsContent = reportsContent
        }
    }
}
