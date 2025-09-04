//
//  OnboardingStore.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import Foundation

@MainActor
final class OnboardingStore: ObservableObject {
    
    @Published private(set) var state = OnboardingState()
    private let effect = OnboardingEffect(
        townService : TownService(),
        onboardingService : OnboardingService(),
        userService : UserService()
    )
    
    func dispatch(_ action: OnboardingAction) {
        OnboardingReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .updateNickname(let nickname):
            state.nickname = nickname
            
            if nickname.isEmpty {
                state.nicknameType = .placeholder
            } else {
                state.nicknameType = .editing
            }

        case .checkNickname(let nickname):
            if nickname.isEmpty {
                dispatch(.nicknameChecked(.placeholder))
            } else if nickname.contains(where: { !$0.isLetter && !$0.isNumber }) {
                dispatch(.nicknameChecked(.invalidCharacter))
            } else if nickname.count <= 1 {
                dispatch(.nicknameChecked(.shouldTwoCharacter))
            } else {
                Task {
                    let result = await effect.checkNickname(nickname)
                    dispatch(result)
                }
            }
        
        case .fetchTown:
            Task {
                let result = await effect.fetchTownList()
                dispatch(result)
            }
            
        case .fetchPersona:
            Task {
                let result = await effect.fetchPersonaList()
                dispatch(result)
            }
            
        case .onboardingCompleteOnAppear:
            guard let selectedTown = state.selectedTown,
                  let selectedPersona = state.selectedPersona else {
                print("❗️ 선택된 동네나 페르소나가 없습니다.")
                return
            }

            Task {
                let result = await effect.completeOnboarding(
                    selectedTownId: selectedTown.id,
                    favoriteTownIdList: state.townList.map { $0.id },
                    persona: selectedPersona.type,
                    nickname: state.nickname
                )
                dispatch(result)
            }
        case .isLottieFinished:
            state.isLottieFinished = true
            
        default:
            break
        }
    }
}
