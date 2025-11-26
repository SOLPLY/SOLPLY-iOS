//
//  AuthTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

enum AuthTargetType {
    case submitLogin(provider: String, request: AuthLoginRequestDTO)
    case refreshToken(refreshToken: String)
    case fetchLoginInformation
    case logout
}

extension AuthTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .submitLogin: return .contentTypeJSON
        case .refreshToken(let refreshToken): return .refreshToken(refreshToken)
        case .fetchLoginInformation: return .contentTypeJSON
        case .logout: return .contentTypeJSON
        }
    }
    
    var path: String {
        switch self {
        case .submitLogin(let provider, _): return "/auth/social/\(provider)/login"
        case .refreshToken: return "/auth/refresh"
        case .fetchLoginInformation: return "/auth/login-info"
        case .logout: return "/auth/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .submitLogin: return .post
        case .refreshToken: return .post
        case .fetchLoginInformation: return .get
        case .logout: return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .submitLogin(_, let request): return .requestJSONEncodable(request)
        case .refreshToken: return .requestPlain
        case .fetchLoginInformation: return .requestPlain
        case .logout: return .requestPlain
        }
    }
}
