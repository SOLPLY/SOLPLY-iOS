//
//  AuthEffect.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import KakaoSDKUser
import KakaoSDKAuth
import Moya

struct AuthEffect {
    
    // MARK: - Properties
    
    private let service: AuthAPI
    
    // MARK: - Initializer
    
    init(service: AuthAPI) {
        self.service = service
    }
    
    // MARK: - Functions
    
    func login(with socialLoginType: SocialLoginType, token: String = "") async -> AuthAction {
        do {
            var token = token
            
            switch socialLoginType {
            case .kakao:
                token = try await fetchKakaoToken().accessToken
            case .apple:
                break
            }
            
            let request = AuthLoginRequestDTO(token: token)
            let response = try await service.submitLogin(
                provider: socialLoginType.rawValue,
                request: request
            )
            
            guard
                let accessToken = response.data?.accessToken,
                let refreshToken = response.data?.refreshToken,
                let isNewUser = response.data?.isNewUser
            else {
                return .loginFailed(.unknownError)
            }

            TokenManager.shared.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
            
            return .loginSuccess(isNewUser: isNewUser)
        } catch let error as NetworkError {
            return .loginFailed(error)
        } catch {
            return .loginFailed(.unknownError)
        }
    }
}

// MARK: - KakaoLoagin

extension AuthEffect {
    @MainActor
    private func fetchKakaoToken() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { token, error in
                    if let error {
                        continuation.resume(throwing: NetworkError.apiError(message: "⚠️ 카카오 로그인에 실패했습니다: \(error.localizedDescription)"))
                    }
                    
                    if let token = token {
                        continuation.resume(returning: token)
                    } else {
                        continuation.resume(throwing: NetworkError.apiError(message: "⚠️ 카카오 로그인에 실패했습니다: 카카오 토큰 확인을 확인할 수 없습니다."))
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { token, error in
                    if let error {
                        continuation.resume(throwing: NetworkError.apiError(message: "⚠️ 카카오 로그인에 실패했습니다: \(error.localizedDescription)"))
                    }
                    
                    if let token = token {
                        continuation.resume(returning: token)
                    } else {
                        continuation.resume(throwing: NetworkError.apiError(message: "⚠️ 카카오 로그인에 실패했습니다: 카카오 토큰 확인을 확인할 수 없습니다."))
                    }
                }
            }
        }
    }
}

// MARK: - AuthAPI

extension AuthEffect {
    func submitLogin(
        provider: String,
        request: AuthLoginRequestDTO
    ) async throws -> BaseResponseBody<AuthLoginResponseDTO> {
        return try await service.submitLogin(
            provider: provider,
            request: request
        )
    }
    
    func refreshToken(
        refreshToken: String
    ) async throws -> BaseResponseBody<AuthRefreshResponseDTO> {
        return try await service.refreshToken(refreshToken: refreshToken)
    }
}
