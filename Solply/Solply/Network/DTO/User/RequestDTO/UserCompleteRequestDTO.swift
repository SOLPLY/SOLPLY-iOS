//
//  UserCompleteRequestDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserCompleteRequestDTO: Encodable, RequestModelType {
    let selectedTownId: Int
    let persona: String
    let nickname: String
    let policyAgreementInfos: [PolicyAgreementInfo]
}
