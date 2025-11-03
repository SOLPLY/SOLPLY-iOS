//
//  OnboardingCompleteInfo.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct OnboardingCompleteInfo: Encodable {
    let policyAgreementInfos: [PolicyAgreementInfo]
    let townId: Int
    let townName: String
    let persona: String
    let nickname: String

    init(
        townId: Int,
        townName: String,
        persona: String,
        nickname: String,
        policyAgreementInfos: [PolicyAgreementInfo] = []
    ) {
        self.townId = townId
        self.townName = townName
        self.persona = persona
        self.nickname = nickname
        self.policyAgreementInfos = policyAgreementInfos
    }
}

struct PolicyAgreementInfo: Encodable {
    let policyId: Int
    let isAgree: Bool
}

