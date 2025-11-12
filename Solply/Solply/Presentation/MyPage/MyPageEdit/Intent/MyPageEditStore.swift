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
    let profileImageUrl: String
    
    // MARK: - Initializer
    
    init(
        effect: MyPageEditEffect = MyPageEditEffect(
            userService: UserService()
        ),
        userInformation: UserInformation,
        profileImageUrl: String
    ) {
        self.effect = effect
        self.userInformation = userInformation
        self.profileImageUrl = profileImageUrl
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: MyPageEditAction) {
        MyPageEditReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .loadUserInformation:
            state.nickname = userInformation.nickname
            
        case .fetchUserNicknameCheck:
            Task {
                let result = await effect.fetchUserNicknameCheck(nickname: state.nickname)
                self.dispatch(result)
            }
            
        case .updateUserInformation:
            let nickname = state.nickname.isEmpty ? userInformation.nickname : state.nickname
            let persona = PersonaType.allCases.first { $0.personaString == state.selectedPersona }?.rawValue ?? userInformation.persona.rawValue
            
            let request =  UpdateUserInformationRequestDTO(
                nickname: nickname,
                persona: persona,
                profileImageFileKey: nil
            )
            
            Task {
                let result = await effect.updateUserInformation(request: request)
                self.dispatch(result)
            }
        default:
            break
        }
    }
}
