//
//  MyPageAction.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

enum MyPageAction {
    case fetchUser
    case userLoaded(UserInformation)
    case userLoadFailed(error: NetworkError)
    
    case editProfileTapped
    case customerCenterTapped
    case logoutTapped
    case deleteAccountTapped
    
    case fetchLoginInformation
    case fetchLoginInformationSuccess(loginInformation: SocialLoginType?)
    case fetchLoginInformationFailed(error: NetworkError)
}
