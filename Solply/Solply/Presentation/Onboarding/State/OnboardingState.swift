//
//  OnboardingState.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

struct OnboardingState {
    var step: OnboardingStep = .townOption
    
    var townOption: String = ""
    var moodOption: String? = nil
    var nickname: String = ""
}
