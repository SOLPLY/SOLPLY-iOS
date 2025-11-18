//
//  AuthAPI.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

protocol AuthAPI {
    func submitLogin(
        provider: String,
        request: AuthLoginRequestDTO
    ) async throws -> BaseResponseBody<AuthLoginResponseDTO>
    
    func refreshToken(
        refreshToken: String
    ) async throws -> BaseResponseBody<AuthRefreshResponseDTO>
    
    /// 사용자 로그인 정보 조회
    func fetchAuthLoginInformation() async throws -> BaseResponseBody<LoginInformationResponseDTO>
}
