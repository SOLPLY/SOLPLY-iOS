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
    private let effect: OnboardingEffect = OnboardingEffect()

    func dispatch(_ action: OnboardingAction) {
        OnboardingReducer.reduce(state: &state, action: action)
        
        switch action {
        case .updateNickname(let nickname):
            if nickname.isEmpty {
                self.dispatch(.nicknameChecked(.placeholder))
            } else if nickname.contains(where: { !$0.isLetter && !$0.isNumber }) {
                self.dispatch(.nicknameChecked(.invalidCharacter))
            } else if nickname == "중복된이름" {
                self.dispatch(.nicknameChecked(.duplicate))
            } else {
                self.dispatch(.nicknameChecked(.valid))
            }
        case .onboardingCompleteOnAppear:
            Task {
                let result = await effect.waitThenComplete()
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}

