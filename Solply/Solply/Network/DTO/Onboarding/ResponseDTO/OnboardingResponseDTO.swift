//
//  OnboardingResponseDTO.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

// MARK: - Response DTO

struct OnboardingResponseDTO: ResponseModelType {
    let personaList: [PersonaDTO]
    let completeInfo: OnboardingCompleteResponseDTO?
}

struct PersonaDTO: ResponseModelType ,Hashable {
    let personaType: String
    let description: String

    func toEntity() -> Persona {
        return Persona(
            type: personaType,
            description: description
        )
    }
}

struct OnboardingCompleteResponseDTO: ResponseModelType {
    let selectedTownId: Int
    let selectedTownName: String
    let persona: String
    let nickname: String

    func toEntity() -> OnboardingCompleteInfo {
        return OnboardingCompleteInfo(
            townId: selectedTownId,
            townName: selectedTownName,
            persona: persona,
            nickname: nickname
        )
    }
}
