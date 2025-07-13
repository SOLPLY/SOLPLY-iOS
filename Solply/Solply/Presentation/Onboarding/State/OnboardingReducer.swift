//
//  OnboardingReducer.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import Foundation

enum OnboardingReducer {

    static func reduce(state: inout OnboardingState, action: OnboardingAction) {
        switch action {
        case .next:
            if let next = OnboardingStep(rawValue: state.step.rawValue + 1) {
                state.step = next
            }

        case .goBack:
            if let previous = OnboardingStep(rawValue: state.step.rawValue - 1) {
                state.step = previous
            }

        case .skip:
            state.step = .nickName

        case .selectTown(let town):
            state.townOption = town

        case .selectPersona(let persona):
            state.personaOption = persona

        case .updateNickname(let nickname):
            state.nickname = nickname
            
        case .textFieldFullFilled(let isFull):
            state.isTextFieldFullFilled = isFull
            
        case .onboardingCompleteOnAppear:
            state.isOnboardingFinished = true
            
        case .isLottieFinished:
            state.isLottieFinished = true
            
        case .nicknameChecked(let nicknameType):
            state.nicknameType = nicknameType
        }
    }
}
