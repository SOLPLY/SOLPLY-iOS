//
//  BaseTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {
    var headerType: HTTPHeader { get }
}

extension BaseTargetType {
    var baseURL: URL {
        guard let url = URL(string: "\(AppEnvironment.baseURL)/api") else {
            fatalError("Error: BaseURL을 찾을 수 없습니다.")
        }
        
        return url
    }
    
    var headers: [String: String]? {
        var header = ["Content-Type": "application/json"]
        
        switch headerType {
        case .contentTypeJSON:
            break
        case .accessToken:
            if let accessToken = TokenManager.shared.fetchAccessToken() {
                header["Authorization"] = "Bearer \(accessToken)"
            } else {
                print("‼️ AccessToken이 없습니다 ‼️")
            }
            
        case .refreshToken(let refreshToken):
            header["Authorization"] = "Bearer \(refreshToken)"
        }
        
        return header
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

enum HTTPHeader {
    case contentTypeJSON
    case accessToken // 추후 Interceptor로 수정 필요
    case refreshToken(String)
}
