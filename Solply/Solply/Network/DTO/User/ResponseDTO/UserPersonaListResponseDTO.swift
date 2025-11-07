//
//  UserPersonaListResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserPersonaListResponseDTO: ResponseModelType {
    let personaList: [PersonaDTO]
}

struct PersonaDTO: ResponseModelType, Hashable {
    let personaType: String
    let description: String

    func toEntity() -> Persona {
        Persona(type: personaType, description: description)
    }
}
