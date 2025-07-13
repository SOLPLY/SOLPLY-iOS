//
//  OnboardingEffect.swift
//  Solply
//
//  Created by 선영주 on 7/12/25.
//

struct OnboardingEffect {
    func waitThenComplete() async -> OnboardingAction {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return .isLottieFinished
    }
}
