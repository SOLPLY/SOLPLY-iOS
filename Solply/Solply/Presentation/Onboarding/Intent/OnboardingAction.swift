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
    
    case selectTown(TownOptionType)
    case selectPersona(PersonaType)
    
    case updateNickname(String)
    case textFieldFullFilled(Bool)
    
    case nicknameChecked(NicknameTextFieldState)
}
