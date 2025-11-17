//
//  UserInformation.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct UserInformation: Hashable {
    let userId: Int
    let nickname: String
    let persona: PersonaType
    let townName: String
    let townId: Int
    let profileImageUrl: String?
}

extension UserInformation {
    init(dto: UserInformationResponseDTO) {
        userId = dto.userId
        nickname = dto.nickname
        persona = dto.persona
        townName = dto.selectedTown.townName
        townId = dto.selectedTown.townId
        profileImageUrl = dto.profileImageUrl
    }
}
