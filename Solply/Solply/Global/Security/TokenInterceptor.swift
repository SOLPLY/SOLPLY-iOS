//
//  TokenInterceptor.swift
//  Solply
//
//  Created by sun on 9/12/25.
//

import Foundation

import Alamofire

final class TokenInterceptor: RequestInterceptor {

    // MARK: - Singleton
    static let shared = TokenInterceptor()
    private init() {}

    // MARK: - Config
    /// 인증 제외 경로 (Authorization 미부착하려고)
    private let skipAuthKeywords: [String] = [
        "/auth/login",
        "/auth/social",
        "/auth/refresh"
    ]

    // MARK: - Adapt: Authorization 부착
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var req = urlRequest
        let path = req.url?.path ?? ""

        // 로그인/리프레시 요청은 건드리지 않음
        guard shouldAttachAuth(for: path) else {
            return completion(.success(req))
        }

        // 이미 Authorization 있으면 덮지 않음
        if req.value(forHTTPHeaderField: "Authorization") == nil,
           let accessToken = TokenManager.shared.fetchAccessToken(),
           !accessToken.isEmpty {
            req.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            debug(" Authorization 추가: \(path)")
            
            print("🔐 [FULL] Authorization: Bearer \(accessToken)")
        }

        completion(.success(req))
    }

    // MARK: - Retry: 401/403 이면, 그 요청에 한해서만 1회 재발급 후 재시도
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        let status = (request.task?.response as? HTTPURLResponse)?.statusCode ?? -1
        let path = request.request?.url?.path ?? ""
        debug("♻️ retry 확인: \(path) status=\(status) retryCount=\(request.retryCount)")

        // 인증 제외 경로는 관여하지 않음
        if shouldSkipAuth(for: path) {
            return completion(.doNotRetryWithError(error))
        }

        // 401/403만 재시도
        guard (status == 401 || status == 403), request.retryCount == 0 else {
            return completion(.doNotRetryWithError(error))
        }

        // 이 요청만 재발급 시도
        Task {
            do {
                try await refreshTokensOnce()
                debug("✅ 재발급 성공 → 요청 재시도")
                completion(.retry)
            } catch let tokenError as TokenError {
                TokenManager.shared.clearTokens()
                debug("❌ 재발급 실패(\(tokenError.description)) → 재시도 중단")
                completion(.doNotRetry)
            } catch {
                TokenManager.shared.clearTokens()
                debug("❌ 재발급 실패(unknown: \(error.localizedDescription)) → 재시도 중단")
                completion(.doNotRetry)
            }
        }
    }
}

// MARK: - Private
private extension TokenInterceptor {

    func refreshTokensOnce() async throws {
        guard let refreshToken = TokenManager.shared.fetchRefreshToken(),
              !refreshToken.isEmpty else {
            throw TokenError.noRefreshToken
        }

        let service = AuthService()
        let res = try await service.refreshToken(refreshToken: refreshToken)

        guard let wrapper = res.data else {
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
