//
//  UserTownsUpdateResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserTownsUpdateResponseDTO: ResponseModelType {
    let selectedTown: TownDTO
    let favoriteTownList: [TownDTO]
}
