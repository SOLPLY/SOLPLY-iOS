//
//  AuthEffect.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import KakaoSDKUser
import KakaoSDKAuth

struct AuthEffect {
    
    // MARK: - Properties
    
    private let service: AuthAPI

    // MARK: - Initializer

    init(service: AuthAPI) {
        self.service = service
    }

    // MARK: - Functions
    
    @MainActor
    func login(provider: String) async -> AuthAction {
        do {
            let oauthToken = try await fetchKakaoToken()
            let request = AuthLoginRequestDTO(oauthAccessToken: oauthToken.accessToken)
            let response = try await service.submitLogin(provider: provider, request: request)
            print(response)
            return .loginSuccess
        } catch let error as NetworkError {
            return .loginFailed(error)
        } catch {
            return .loginFailed(.unknownError)
        }
    }

    @MainActor
    private func fetchKakaoToken() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { token, error in
                    if let token = token {
                        continuation.resume(returning: token)
                    } else {
                        continuation.resume(throwing: error ?? NSError(domain: "KakaoLogin", code: -1))
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { token, error in
                    if let token = token {
                        continuation.resume(returning: token)
                    } else {
                        continuation.resume(throwing: error ?? NSError(domain: "KakaoLogin", code: -1))
                    }
                }
            }
        }
    }
}

// MARK: - Implementation

extension AuthEffect: AuthAPI {
    func submitLogin(provider: String, request: AuthLoginRequestDTO) async throws -> BaseResponseBody<AuthLoginResponseDTO> {
        return try await service.submitLogin(provider: provider, request: request)
    }
}
