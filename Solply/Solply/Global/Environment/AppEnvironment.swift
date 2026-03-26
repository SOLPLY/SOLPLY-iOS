//
//  AppEnvironment.swift
//  Solply
//
//  Created by 김승원 on 7/3/25.
//

import Foundation


enum AppEnvironment {
    /// BaseURL
    static let baseURL: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("Info.plist에 Base_URL이 없습니다.")
        }
        
        return baseURL
    }()
    
    /// Naver 검색 ClientId
    static let naverSearchClientId: String = {
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "NAVER_SEARCH_CLIENT_ID") as? String else {
            fatalError("Info.plist에 NAVER_SEARCH_CLIENT_ID가 없습니다.")
        }
        
        return clientId
    }()
    
    /// Naver 검색 SecretKey
    static let naverSearchClientSecret: String = {
        guard let secret = Bundle.main.object(forInfoDictionaryKey: "NAVER_SEARCH_CLIENT_SECRET") as? String else {
            fatalError("Info.plist에 NAVER_SEARCH_CLIENT_SECRET가 없습니다.")
        }
        
        return secret
    }()
    
    /// 개인정보 처리방침 URL
    static let privacyPolicyURL: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "PRIVACY_POLICY_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("Info.plist에 PRIVACY_POLICY_URL이 없거나 URL 형식이 잘못되었습니다.")
        }
        return url
    }()

    /// 서비스 이용약관 URL
    static let servicePolicyURL: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "SERVICE_POLICY_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("Info.plist에 SERVICE_POLICY_URL이 없거나 URL 형식이 잘못되었습니다.")
        }
        return url
    }()
    
    /// 고객센터 URL
    static let customerCenterURL: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "CUSTOMER_CENTER_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("Info.plist에 CUSTOMER_CENTER_URL이 없거나 URL 형식이 잘못되었습니다.")
        }
        return url
    }()
    
    /// solply 앱 버전
    static let appVersion: String = {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }
        
        return "v" + version
    }()
    
    /// Amplitude Api Key
    static let amplitudeApiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "AMPLITUDE_API_KEY") as? String else {
            fatalError("Info.plist에 AMPLITUDE_API_KEY가 없습니다.")
        }
        
        return apiKey
    }()
}
