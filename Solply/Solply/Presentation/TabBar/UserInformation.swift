//
//  UserInformation.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct UserInformation {
    let nickname: String
    let persona: String
    let townName: String
}

extension UserInformation {
    init(dto: UserInformationResponseDTO) {
        nickname = dto.nickname
        persona = dto.persona
        townName = dto.selectedTown.townName
    }
}
