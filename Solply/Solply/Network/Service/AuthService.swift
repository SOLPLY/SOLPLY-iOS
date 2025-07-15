//
//  AuthService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class AuthService: BaseService<AuthTargetType> { }

extension AuthService: AuthAPI {
    func login(provider: String, request: AuthLoginRequestDTO) async throws -> BaseResponseBody<AuthLoginResponseDTO> {
        return try await self.request(with: .login(provider: provider, request: request))
    }
}
