//
//  MyPageEditAction.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

enum MyPageEditAction {
    case loadUserInformation
    
    case nicknameChanged(nickname: String)
    case personaSelected(persona: String)
    
    // api
    case fetchUserNicknameCheck
    case fetchUserNicknameCheckSuccess(isDuplicated: Bool)
    case fetchUserNicknameCheckFailed(error: NetworkError)
    
    case updateUserInformation
    case updateUserInformationSuccess
    case updateUserInformationFailed(error: NetworkError)
}
