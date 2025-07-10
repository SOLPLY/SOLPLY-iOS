//
//  OnboardingReducer.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

struct OnboardingReducer {

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
            
        case .selectPersona(let persona):
            state.personaOption = persona
        }

    }
}
