//
//  AuthReducer.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

enum AuthReducer {
    static func reduce(state: inout AuthState, action: AuthAction) {
        
        switch action {
        case .login:
            break
            
        case .loginSuccess:
            state.isLoggedIn = true
            print(state.isLoggedIn)
            
        case .loginFailed:
            state.isLoggedIn = false
            print(state.isLoggedIn)
        }
    }
}
