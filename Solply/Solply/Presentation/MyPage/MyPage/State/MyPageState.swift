//
//  MyPageState.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

struct MyPageState {
    var user: UserInformation?
    var registeredPlaces: [UserPlace] = []
    var error: NetworkError?
    var loginInformation: SocialLoginType?
    
    var shouldChangeRoot: Bool = false
}
