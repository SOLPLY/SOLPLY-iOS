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
    let selectedTown: TownDTO
    let persona: String
}

struct TownDTO: ResponseModelType{
    let townId: Int
    let townName: String
}
