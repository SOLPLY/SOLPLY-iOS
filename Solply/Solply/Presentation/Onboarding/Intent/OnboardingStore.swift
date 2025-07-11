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
            
            OnboardingReducer.reduce(state: &state, action: .updateNickname(trimmed))
            
            OnboardingReducer.reduce(state: &state, action: .validateNickname(trimmed))
            
            let isFull = trimmed.count == 8
            OnboardingReducer.reduce(state: &state, action: .textFieldFullFilled(isFull))

        default:
            OnboardingReducer.reduce(state: &state, action: action)
        }
    }
}
