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
            
        case .loginFailed(let networkError):
            state.isLoggedIn = false
            print(networkError.description)
        }
    }
}
