//
//  UserCompleteResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserCompleteResponseDTO: ResponseModelType {
    let selectedTownId: Int
    let selectedTownName: String
    let persona: String
    let nickname: String

    func toEntity() -> OnboardingCompleteInfo {
        OnboardingCompleteInfo(
            policyAgreementInfos: [],
            townId: selectedTownId,
            townName: selectedTownName,
            persona: persona,
            nickname: nickname
        )
    }
}
