//
//  TownResponseDTO.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct TownResponseDTO: ResponseModelType {
    let selectedTown: TownDTO?
    let favoriteTownList: [TownDTO]
}

struct TownDTO: ResponseModelType, Hashable {
    let townId: Int
    let townName: String
}

extension TownDTO {
    func toEntity() -> Town {
        Town(id: townId, name: townName)
    }
}
