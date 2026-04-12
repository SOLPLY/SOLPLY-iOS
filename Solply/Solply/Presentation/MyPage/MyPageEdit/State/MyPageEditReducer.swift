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
        case .attachProfileImage(let imageData):
            state.attachedImageData = imageData
            state.isUserInformationChanged = true
            
        case .deleteProfileImage:
            state.attachedImageData = ("", Data())
            state.isUserInformationChanged = true
            break
            
        case .loadUserInformation:
            break
            
        case .nicknameChanged(let text):
            state.nickname = text
            state.nicknameTextFieldState = .editing
            state.isUserInformationChanged = true

        case .personaSelected(let persona):
            state.selectedPersona = persona
            state.isUserInformationChanged = true
            
        case .startUpdateUserInformation:
            state.isCompleteButtonLoading = true
            
        case .fetchUserNicknameCheck:
            break
            
        case .fetchUserNicknameCheckSuccess(let isDuplicated):
            state.nicknameTextFieldState = isDuplicated ? .duplicate : .valid
            state.isCompleteButtonEnabled = !isDuplicated
            break
            
        case .fetchUserNicknameCheckFailed(let error):
            print(error)
            if state.nickname.count < 2 {
                state.nicknameTextFieldState = .shouldTwoCharacter
            } else {
                state.nicknameTextFieldState = .invalidCharacter
            }
            
            state.isCompleteButtonEnabled = false
            
        case .updateUserInformation:
            break
            
        case .updateUserInformationSuccess:
            state.shouldGoBack = true
            state.isCompleteButtonLoading = false
            break
            
        case .updateUserInformationFailed(let error):
            print(error)
            state.isCompleteButtonLoading = false
            break
        }
    }
}
