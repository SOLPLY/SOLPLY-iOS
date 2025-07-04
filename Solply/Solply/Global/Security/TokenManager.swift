//
//  TokenManager.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

final class TokenManager {
    
    static let shared = TokenManager()
    private let keychain = KeychainManager.shared
    
    private init() {}
    
    /// 로그인 성공 후 발급받은 토큰을 Keychain에 저장합니다.
    ///
    /// - Parameters:
    ///   - accessToken: 사용자 인증에 사용되는 액세스 토큰입니다. 필수로 저장됩니다.
    ///   - refreshToken: 액세스 토큰 만료 시 재발급에 사용되는 리프레시 토큰입니다. 값이 있는 경우에만 저장됩니다.
    func saveTokens(accessToken: String, refreshToken: String? = nil) {
        keychain.create(forKey: .accessToken, token: accessToken)
        
        if let refreshToken {
            keychain.create(forKey: .refreshToken, token: refreshToken)
        }
    }
    
    /// 저장된 accessToken을 반환합니다.
    func fetchAccessToken() -> String? {
        return keychain.read(forKey: .accessToken)
    }

    /// 저장된 refreshToken을 반환합니다.
    func fetchRefreshToken() -> String? {
        return keychain.read(forKey: .refreshToken)
    }
    
    /// 로그아웃 시 모든 토큰을 삭제합니다.
    func clearTokens() {
        keychain.delete(forKey: .accessToken)
        keychain.delete(forKey: .refreshToken)
    }
    
    /// accessToken과 refreshToken이 모두 존재하는지 확인합니다.
    /// 자동 로그인 가능한 상태인지를 판별합니다.
    var isSessionAvailable: Bool {
        guard let accessToken = fetchAccessToken(), !accessToken.isEmpty,
              let refreshToken = fetchRefreshToken(), !refreshToken.isEmpty else { return false }
        
        return true
    }
}
