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
            
        case .changeReportsStep(let reportsStep):
            state.reportsStep = reportsStep
            
        case .editReportsContent(let reportsContent):
            state.reportsContent = reportsContent
            
        case .startLottie:
            break
            
        case .endLottie:
            state.shouldGoBack = true
        }
    }
}
