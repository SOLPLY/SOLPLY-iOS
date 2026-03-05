//
//  UserTownsUpdateResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserTownsUpdateResponseDTO: ResponseModelType {
    let selectedTown: SelectedTown
}

struct SelectedTown: ResponseModelType {
    let townId: Int
    let townName: String
}
