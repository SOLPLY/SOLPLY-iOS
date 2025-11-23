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
            
        case .submitPresignedUrlRequest:
            break
            
        case .submitPresignedUrlRequestSuccess:
            break
            
        case .submitPresignedUrlRequestFailed(let error):
            print(error)
            break
            
        case .photoUploadSuccess:
            print("S3 사진 업로드 성공")
            break
            
        case .photoUploadFailed(let error):
            print("S3 사진 업로드 실패 error: \(error)")
            break
        }
    }
}
