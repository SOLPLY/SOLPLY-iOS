//
//  UserInformationResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct UserInformationResponseDTO: ResponseModelType {
    let userId: Int
    let nickname: String
    let selectedTown: SelectedTownDTO
    let persona: PersonaType
}

struct SelectedTownDTO: ResponseModelType{
    let townId: Int
    let townName: String
}
