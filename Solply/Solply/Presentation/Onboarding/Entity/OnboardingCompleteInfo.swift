//
//  OnboardingCompleteInfo.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct OnboardingCompleteInfo {
    let policyAgreementInfos: [PolicyAgreementInfo]
    let townId: Int
    let townName: String
    let persona: String
    let nickname: String
}

struct PolicyAgreementInfo {
    let policyId: Int
    let isAgree: Bool
}
