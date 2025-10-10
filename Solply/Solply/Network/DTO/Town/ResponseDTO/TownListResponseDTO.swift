//
//  TownListResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct TownListResponseDTO: ResponseModelType, Decodable {
    let towns: [TownDTO]
}

struct TownDTO: ResponseModelType, Decodable, Hashable {
    let townId: Int
    let townName: String
    let subTowns: [SubTownDTO]?
}

struct SubTownDTO: ResponseModelType, Decodable, Hashable {
    let townId: Int
    let townName: String?
    let name: String?
    
    var displayName: String { name ?? townName ?? "" }
}

