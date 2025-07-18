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
            
        case .loginSuccess(let accessToken, let refreshToken, let isNewUser):
            state.isLoggedIn = true
            state.accessToken = accessToken
            state.refreshToken = refreshToken
            state.isNewUser = isNewUser
            
        case .loginFailed(let networkError):
            state.isLoggedIn = false
            print(networkError.description)
        }
    }
}
