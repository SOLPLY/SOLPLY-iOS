//
//  UserInformation.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct UserInformation {
    let nickname: String
    let persona: PersonaType
    let townName: String
    let townId: Int
}

extension UserInformation {
    init(dto: UserInformationResponseDTO) {
        nickname = dto.nickname
        persona = dto.persona
        townName = dto.selectedTown.townName
        townId = dto.selectedTown.townId
    }
}
