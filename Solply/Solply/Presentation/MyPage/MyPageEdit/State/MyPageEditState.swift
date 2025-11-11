//
//  MyPageEditState.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

struct MyPageEditState {
    var nickname: String = ""
    var nicknameTextFieldState: NicknameTextFieldState = .editing
    
    var selectedPersona: String? = nil
    
    var isUserInformationChanged: Bool = false
}
