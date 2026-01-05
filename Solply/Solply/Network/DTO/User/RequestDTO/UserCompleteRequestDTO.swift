//
//  UserCompleteRequestDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserCompleteRequestDTO: RequestModelType {
    let persona: String
    let nickname: String
    let policyAgreementInfos: [PolicyAgreementInfoDTO]
    
    init(
        persona: String,
        nickname: String,
        policyAgreementInfos: [PolicyAgreementInfo] = []
    ) {
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

