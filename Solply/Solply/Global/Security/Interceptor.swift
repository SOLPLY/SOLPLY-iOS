//
// Interceptor.swift
//  Solply
//
//  Created by sun on 9/12/25.
//

import Foundation

import Alamofire

extension Notification.Name {
    static let tokenExpired = Notification.Name("tokenExpired")
}

final class Interceptor: RequestInterceptor {

    // MARK: - Singleton
    
    static let shared = Interceptor()
    private init() {}

    // MARK: - Config
    
    private let skipAuthKeywords: [String] = [
        "/auth/login",
        "/auth/social",
        "/auth/refresh"
    ]

    // MARK: - Adapt
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        let path = request.url?.path ?? ""

        guard shouldAttachAuth(for: path) else {
            return completion(.success(request))
        }

        if request.value(forHTTPHeaderField: "Authorization") == nil,
           let accessToken = TokenManager.shared.fetchAccessToken(),
           !accessToken.isEmpty {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            debug(" Authorization 추가: \(path)")
            print("🔐 [FULL] Authorization: Bearer \(accessToken)")
        }

        completion(.success(request))
    }

    // MARK: - Retry
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        let status = (request.task?.response as? HTTPURLResponse)?.statusCode ?? -1
        let path = request.request?.url?.path ?? ""
        debug("♻️ retry 확인: \(path) status=\(status) retryCount=\(request.retryCount)")

        if shouldSkipAuth(for: path) {
            return completion(.doNotRetryWithError(error))
        }

        guard status == 401, request.retryCount == 0 else {
            return completion(.doNotRetryWithError(error))
        }

        Task {
            do {
                try await refreshTokensOnce()
                debug("✅ 재발급 성공 → 요청 재시도")
                completion(.retry)
            } catch {
                TokenManager.shared.clearTokens()
                debug("❌ 재발급 실패 → 재시도 중단")

                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .tokenExpired, object: nil)
                }

                completion(.doNotRetry)
            }
        }
    }
}

// MARK: - Private

private extension Interceptor {

    func refreshTokensOnce() async throws {
        guard let refreshToken = TokenManager.shared.fetchRefreshToken(),
              !refreshToken.isEmpty else {
            throw TokenError.noRefreshToken
        }

        let service = AuthService()
        let response = try await service.refreshToken(refreshToken: refreshToken)

        guard let wrapper = response.data else {
            throw TokenError.reissueFailed
        }

        let token = wrapper.data

        guard !token.accessToken.isEmpty else {
            throw TokenError.reissueFailed
        }

        TokenManager.shared.saveTokens(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
    }

    func shouldSkipAuth(for path: String) -> Bool {
        skipAuthKeywords.contains { path.contains($0) }
    }

    func shouldAttachAuth(for path: String) -> Bool {
        !shouldSkipAuth(for: path)
    }

    func debug(_ message: String) {
        print("🍏 [TokenInterceptor] \(message)")
    }
}
