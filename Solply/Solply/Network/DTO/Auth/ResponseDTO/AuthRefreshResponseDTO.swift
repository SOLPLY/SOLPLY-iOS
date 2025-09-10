//
//  AuthRefreshResponseDTO.swift
//  Solply
//
//  Created by sun on 9/11/25.
//

import Foundation

struct AuthRefreshResponseDTO: ResponseModelType {
    let success: Bool
    let code: String
    let message: String
    let data: TokenData
    
    struct TokenData: Codable {
        let accessToken: String
        let refreshToken: String
    }
}
