//
//  OnboardingAction.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import Foundation

enum OnboardingAction {
    case next
    case goBack
    case skip

    case updateNickname(String)
    case updateNicknameText(String)
    case textFieldFullFilled(Bool)

    case checkNickname(String)
    case checkNicknameSuccess(Bool)
    case checkNicknameFailure(String)

    case fetchTowns
    case fetchTownsSuccess(townList: [Town])
    case fetchTownsFailure(String)
    
    case selectTown(Town)
    case selectSubTown(SubTown)

    case fetchPersona
    case fetchPersonaSuccess([Persona])
    case fetchPersonaFailure(String)
    
    case selectPersona(Persona)

    case nicknameChecked(NicknameTextFieldState)

    case completeOnboardingRequest
    case completeOnboardingSuccess
    case completeOnboardingFailure(String)

    case onboardingCompleteOnAppear
    case isLottieFinished
}
