//
//  Town.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

struct Town: Hashable, Identifiable {
    let id: Int
    let name: String
}

struct TopTown: Hashable, Identifiable {
    let id: Int
    let name: String
    let subTowns: [Town]
}
