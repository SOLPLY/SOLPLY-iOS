//
//  AuthLoginResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

struct AuthLoginResponseDTO: ResponseModelType {
    let accessToken: String
    let refreshToken: String
    let isNewUser: Bool
}
