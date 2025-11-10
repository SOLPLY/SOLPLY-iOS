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
            state.isLoading = true
            
        case .loginSuccess(let isNewUser):
            state.isLoggedIn = true
            state.isNewUser = isNewUser
            state.isLoading = false
            
        case .loginFailed(let networkError):
            state.isLoggedIn = false
            state.isLoading = false
            print(networkError.description)
        }
    }
}
