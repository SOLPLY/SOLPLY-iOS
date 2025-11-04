//
//  UserPoliciesResponseDTO.swift
//  Solply
//
//  Created by sun on 11/3/25.
//

import Foundation

struct UserPoliciesResponseDTO: ResponseModelType {
    let userPolicies: [PolicyDTO]
}

struct PolicyDTO: ResponseModelType {
    let id: Int
    let policyType: String
    let title: String
    let content: String
    let required: Bool
}

extension PolicyDTO {
    func toEntity() -> Policy {
        Policy(
            id: id,
            title: title,
            content: content,
            isRequired: required,
            isAgreed: false
        )
    }
}
