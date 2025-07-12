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
            let trimmed = String(nickname.prefix(8))
            self.dispatch(.updateNickname(trimmed))
            self.dispatch(.validateNickname(trimmed))

            let isFull = trimmed.count == 8
            self.dispatch(.textFieldFullFilled(isFull))
            

        default:
            OnboardingReducer.reduce(state: &state, action: action)
        }
    }
}
