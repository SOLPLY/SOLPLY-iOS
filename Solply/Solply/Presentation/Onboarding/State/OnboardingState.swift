//
//  OnboardingState.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

struct OnboardingState {
    var step: OnboardingStep = .townOption
    
    var townOption: TownOptionType? = nil
    var personaOption: PersonaType? = nil
    var nickname: String = ""
}
