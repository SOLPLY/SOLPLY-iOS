//
//  MyPageEditAction.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

enum MyPageEditAction {
    case loadUserInformation
    
    case attachProfileImage(imageData: (String, Data))
    case deleteProfileImage
    case nicknameChanged(nickname: String)
    case personaSelected(persona: String)
    
    case startUpdateUserInformation
    
    // api
    case fetchUserNicknameCheck
    case fetchUserNicknameCheckSuccess(isDuplicated: Bool)
    case fetchUserNicknameCheckFailed(error: NetworkError)
    
    case updateUserInformation(imageKeyString: String?)
    case updateUserInformationSuccess(nickName: String, persona: String)
    case updateUserInformationFailed(error: NetworkError)
}
