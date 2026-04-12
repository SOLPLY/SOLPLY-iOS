//
//  MyPageAction.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

enum MyPageAction {
    case fetchLoginInformation
    case fetchLoginInformationSuccess(loginInformation: SocialLoginType?)
    case fetchLoginInformationFailed(error: NetworkError)
    
    case logout
    case logoutSuccess
    case logoutFailed(error: NetworkError)
}
