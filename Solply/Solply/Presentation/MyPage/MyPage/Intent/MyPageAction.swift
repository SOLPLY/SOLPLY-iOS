//
//  MyPageAction.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

enum MyPageAction {
    case fetchUser
    case fetchRegisteredPlaces(userId: Int, page: Int = 1, size: Int = 3)
    case userLoaded(UserInformation)
    case registeredPlacesLoaded([UserPlace])
    case userLoadFailed(error: NetworkError)
    case registeredPlacesLoadFailed(error: NetworkError)
    
    case editProfileTapped
    case customerCenterTapped
    case logoutTapped
    case deleteAccountTapped
    
    case fetchLoginInformation
    case fetchLoginInformationSuccess(loginInformation: SocialLoginType?)
    case fetchLoginInformationFailed(error: NetworkError)
}
