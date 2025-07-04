//
//  KeychainManager.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

final class KeychainManager {
    
    static let shared = KeychainManager()
    private init() {}
    
    /// 주어진 토큰을 Keychain에 저장합니다.
    /// - Parameters:
    ///   - key: 저장할 토큰의 종류 (예: `.accessToken`, `.refreshToken`)
    ///   - token: 서버로부터 발급받은 토큰 문자열
    func create(forKey key: KeychainType, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: token.data(using: .utf8) as Any
        ]
        
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    /// Keychain에 저장된 토큰 값을 읽어옵니다.
    /// - Parameter key: 조회할 토큰 항목의 키
    /// - Returns: 저장된 토큰 문자열 또는 존재하지 않거나 읽기에 실패한 경우 `nil`
    func read(forKey key: KeychainType) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            if let data: Data = result as? Data {
                let value = String(data: data, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code: \(status)")
            return nil
        }
    }
    
    /// Keychain에 저장된 토큰 값을 삭제합니다.
    /// - Parameter key: 삭제할 토큰 항목의 키
    func delete(forKey key: KeychainType) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ]
        
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code: \(status)")
    }
}

extension KeychainManager {
    enum KeychainType: String {
        case accessToken
        case refreshToken
    }
}
