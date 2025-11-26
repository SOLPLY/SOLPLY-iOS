//
//  AuthRefreshResponseDTO.swift
//  Solply
//
//  Created by sun on 9/11/25.
//

import Foundation

struct AuthRefreshResponseDTO: ResponseModelType {
    let accessToken: String
    let refreshToken: String
}

