//
//  MyPageEditReducer.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

enum MyPageEditReducer {
    static func reduce(state: inout MyPageEditState, action: MyPageEditAction) {
        switch action {
        case .loadUserInformation:
            break
            
        case .nicknameChanged(let text):
            state.nickname = text
            state.nicknameTextFieldState = .editing

        case .personaSelected(let persona):
            state.selectedPersona = persona

        case .completeTapped:
            // 저장/검증/API 호출 등은 외부에서 처리
            break
            
        case .fetchUserNicknameCheck:
            break
            
        case .fetchUserNicknameCheckSuccess(let isDuplicated):
            state.nicknameTextFieldState = isDuplicated ? .duplicate : .valid
            break
            
        case .fetchUserNicknameCheckFailed(let error):
            print(error)
            if state.nickname.count < 2 {
                state.nicknameTextFieldState = .shouldTwoCharacter
            } else {
                state.nicknameTextFieldState = .invalidCharacter
            }
            
        case .updateUserInformation:
            break
            
        case .updateUserInformationSuccess:
            state.shouldGoBack = true
            break
            
        case .updateUserInformationFailed(let error):
            print(error)
            break
        }
    }
}
