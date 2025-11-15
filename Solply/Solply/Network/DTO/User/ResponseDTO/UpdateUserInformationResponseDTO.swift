//
//  UpdateUserInformationResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 11/12/25.
//

import Foundation

struct UpdateUserInformationResponseDTO: ResponseModelType {
    let nickname: String
    let persona: String
    let profileImageFileKey: String?
}
