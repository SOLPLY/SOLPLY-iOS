//
//  TownListResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct TownListResponseDTO: ResponseModelType {
    let towns: [TownDTO]
}

struct TownDTO: ResponseModelType, Hashable {
    let townId: Int
    let townName: String
    let subTowns: [TownDTO]?
}

extension TownDTO {
    func toEntity() -> Town {
        Town(id: townId, name: townName)
    }
}
