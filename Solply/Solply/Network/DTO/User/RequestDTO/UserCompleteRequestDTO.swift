//
//  UserCompleteRequestDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserCompleteRequestDTO: RequestModelType {
    let selectedTownId: Int
    let persona: String
    let nickname: String
    let policyAgreementInfos: [PolicyAgreementInfoDTO]
    
    init(
        selectedTownId: Int,
        persona: String,
        nickname: String,
        policyAgreementInfos: [PolicyAgreementInfo] = []
    ) {
        self.selectedTownId = selectedTownId
        self.persona = persona
        self.nickname = nickname
        self.policyAgreementInfos = policyAgreementInfos.map {
            PolicyAgreementInfoDTO(policyId: $0.policyId, isAgree: $0.isAgree)
        }
    }
    
    struct PolicyAgreementInfoDTO: RequestModelType {
        let policyId: Int
        let isAgree: Bool
    }
}

