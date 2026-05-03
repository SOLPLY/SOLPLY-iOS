//
//  MyPageReducer.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

enum MyPageReducer {
    static func reduce(state: inout MyPageState, action: MyPageAction) {
        switch action {
        case .fetchLoginInformation:
            break
            
        case .fetchLoginInformationSuccess(let loginInformation):
            state.loginInformation = loginInformation
            
        case .fetchLoginInformationFailed(let error):
            state.error = error
            print(error)
            break
            
        case .logout:
            break
            
        case .logoutSuccess:
            TokenManager.shared.clearTokens()
            state.shouldChangeRoot = true
            break
            
        case .logoutFailed(let error):
            state.error = error
            print(error)
        }
    }
}
