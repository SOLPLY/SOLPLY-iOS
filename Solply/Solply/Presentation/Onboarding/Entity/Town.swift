//
//  Town.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

struct SubTown: Hashable, Identifiable {
    let id: Int
    let townName: String
}

struct Town: Hashable, Identifiable {
    let id: Int
    let townName: String
    let subTowns: [SubTown]
}
