//
//  MyPageEditStore.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

@MainActor
final class MyPageEditStore: ObservableObject {
    
    // MARK: - Properites
    
    @Published private(set) var state = MyPageEditState()
    
    private let effect: MyPageEditEffect
    
    let userInformation: UserInformation
    
    // MARK: - Initializer
    
    init(
        userInformation: UserInformation,
    ) {
        self.userInformation = userInformation
        self.effect = MyPageEditEffect(userService: UserService())
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: MyPageEditAction) {
        MyPageEditReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .loadUserInformation:
            state.nickname = userInformation.nickname
            // TODO: -  이게 진짜 필요한 건가 고민해보자
            
        case .fetchUserNicknameCheck:
            Task {
                let result = await effect.fetchUserNicknameCheck(nickname: state.nickname)
                self.dispatch(result)
            }
            
        case .startUpdateUserInformation:
            Task {
                if let attachedImageData = state.attachedImageData {
                    let imageKeyStrings = await PhotoUploadManager.shared.upload(
                        imageDatas: [attachedImageData]
                    )
                    
                    self.dispatch(.updateUserInformation(imageKeyString: imageKeyStrings.first ?? ""))
                } else {
                    self.dispatch(.updateUserInformation(imageKeyString: nil))
                }
            }
            
        case .updateUserInformation(let imageKeyString):
            let nickname = state.nickname.isEmpty ? userInformation.nickname : state.nickname
            let persona = PersonaType.allCases.first { $0.personaString == state.selectedPersona }?.rawValue ?? userInformation.persona.rawValue
            
            let request =  UpdateUserInformationRequestDTO(
                nickname: nickname,
                persona: persona,
                profileImageFileKey: imageKeyString
            )
            
            Task {
                let result = await effect.updateUserInformation(request: request)
                self.dispatch(result)
            }
            
        case .updateUserInformationSuccess(let nickName, let persona):
            let changedFields: [AmplitudeChangedField] = [
                userInformation.nickname != nickName ? .nickname : nil,
                userInformation.persona.rawValue != persona ? .personaType : nil
            ].compactMap { $0 }
            
            AmplitudeManager.shared.track(
                .completeProfileEdit(
                    changedFields: changedFields,
                    prevPersona: AmplitudePersonaType.from(personaType: userInformation.persona),
                    newPersona: AmplitudePersonaType.from(text: persona) ?? AmplitudePersonaType.from(personaType: userInformation.persona)
                )
            )
            
        default:
            break
        }
    }
}
