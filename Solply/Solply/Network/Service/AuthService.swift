//
//  AuthService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class AuthService: BaseService<AuthTargetType> { }

// MARK: - Implementation

extension AuthService: AuthAPI {
    func submitLogin(
        provider: String,
        request: AuthLoginRequestDTO
    ) async throws -> BaseResponseBody<AuthLoginResponseDTO> {
        return try await self.request(with: .submitLogin(provider: provider, request: request))
    }
    
    func refreshToken(
        refreshToken: String
    ) async throws -> BaseResponseBody<AuthRefreshResponseDTO> {
        return try await self.request(with: .refreshToken(refreshToken: refreshToken))
    }
    
    func fetchLoginInformation() async throws -> BaseResponseBody<LoginInformationResponseDTO> {
        return try await self.request(with: .fetchLoginInformation)
    }
    
    func logout() async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .logout)
    }
}
