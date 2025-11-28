//
//  TokenRefreshManager.swift
//  Solply
//
//  Created by 김승원 on 11/28/25.
//

import Foundation

final class TokenRefreshManager {
    
    // MARK: - Properties
    
    private var refreshTask: Task<Void, Error>?
    
    // MARK: - Initializer
    
    static let shared = TokenRefreshManager()
    private init() {}
}

// MARK: - Functions

extension TokenRefreshManager {
    /// 토큰 재발급을 시도합니다.
    ///
    /// 이미 refresh가 진행 중인 경우,
    /// 새로운 요청을 실행하지 않고 기존 `refreshTask`의 결과를 기다립니다.
    func refresh() async throws {
        if let task = refreshTask {
            return try await task.value
        }

        let task = Task {
            try await self.performRefresh()
        }
        
        refreshTask = task

        do {
            try await task.value
            refreshTask = nil
            return
        } catch {
            refreshTask = nil
            throw error
        }
    }
}

// MARK: - Private Functions

private extension TokenRefreshManager {
    /// 토큰 재발급 API를 호출합니다.
    func performRefresh() async throws {
        guard let refreshToken = TokenManager.shared.fetchRefreshToken(),
              !refreshToken.isEmpty else {
            throw TokenError.noRefreshToken
        }

        let service = AuthService()
        let response = try await service.refreshToken(refreshToken: refreshToken)

        guard let token = response.data else {
            throw TokenError.reissueFailed
        }

        TokenManager.shared.saveTokens(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
    }
}
