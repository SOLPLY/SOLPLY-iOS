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

    func dispatch(_ action: OnboardingAction) {
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
            
        default:
            OnboardingReducer.reduce(state: &state, action: action)
        }
    }
}
