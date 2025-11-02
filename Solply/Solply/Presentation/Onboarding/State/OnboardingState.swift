//
//  OnboardingState.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

struct OnboardingState {
    var step: OnboardingStep = .onboardingJGD

    var townList: [Town] = []
    var selectedTown: Town? = nil
    var selectedSubTown: SubTown? = nil
    
    var personaList: [Persona] = []
    var selectedPersona: Persona? = nil
    var errorMessage: String? = nil

    var nickname: String = ""
    var nicknameType: NicknameTextFieldState = .placeholder
    var isTextFieldFullFilled: Bool = false
    
    var isLottieFinished: Bool = false
    var isOnboardingFinished: Bool = false
}
