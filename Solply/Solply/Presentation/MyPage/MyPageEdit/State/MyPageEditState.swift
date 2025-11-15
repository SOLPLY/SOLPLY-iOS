//
//  MyPageEditState.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

struct MyPageEditState {
    var nickname: String = ""
    var selectedPersona: String? = nil
    var profileImageUrl: String? = nil
    
    var nicknameTextFieldState: NicknameTextFieldState = .editing
    var isUserInformationChanged: Bool = false
    var shouldGoBack: Bool = false
}
