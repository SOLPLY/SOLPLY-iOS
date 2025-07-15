//
//  AuthAPI.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

protocol AuthAPI {
    func login(provider: String, request: AuthLoginRequestDTO) async throws -> BaseResponseBody<AuthLoginResponseDTO>
}
