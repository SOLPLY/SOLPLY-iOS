//
//  UserResponseDTO.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct CheckNicknameResponseDTO: ResponseModelType {
    let isDuplicated: Bool
}

struct UserResponseDTO: ResponseModelType {
    let selectedTown: TownDTO
    let favoriteTownList: [TownDTO]
    let nickname: String
    let persona: String
}
