//
//  Persona.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct Persona: Hashable, Equatable {
    let type: String
    let description: String

    static func == (lhs: Persona, rhs: Persona) -> Bool {
        return lhs.type == rhs.type
    }
}
