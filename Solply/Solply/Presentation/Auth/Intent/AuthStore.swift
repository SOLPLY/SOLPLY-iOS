//
//  AuthStore.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

@MainActor
final class AuthStore: ObservableObject {
    
    @Published private(set) var state = AuthState()
    private let effect = AuthEffect(service: AuthService())
    
    func dispatch(_ action: AuthAction) {
        AuthReducer.reduce(state: &state, action: action)
        
        switch action {
        case .login(let socialLoginType):
            Task {
                let result = await effect.login(socialLoginType: socialLoginType)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
