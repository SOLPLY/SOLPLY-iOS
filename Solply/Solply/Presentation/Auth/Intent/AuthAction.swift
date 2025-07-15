//
//  AuthAction.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

enum AuthAction {
    
    // LoginAPI
    case login(SocialLoginType)
    case loginSuccess
    case loginFailed(NetworkError)
}
