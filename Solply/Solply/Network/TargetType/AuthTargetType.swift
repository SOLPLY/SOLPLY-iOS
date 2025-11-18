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
    case fetchAuthLoginInformation
}

extension AuthTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .submitLogin: return .contentTypeJSON
        case .refreshToken(let refreshToken): return .refreshToken(refreshToken)
        case .fetchAuthLoginInformation: return .contentTypeJSON
        }
    }
    
    var path: String {
        switch self {
        case .submitLogin(let provider, _): return "/auth/social/\(provider)/login"
        case .refreshToken: return "/auth/refresh"
        case .fetchAuthLoginInformation: return"/auth/login-info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .submitLogin: return .post
        case .refreshToken: return .post
        case .fetchAuthLoginInformation: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .submitLogin(_, let request): return .requestJSONEncodable(request)
        case .refreshToken: return .requestPlain
        case .fetchAuthLoginInformation: return .requestPlain
        }
    }
}
