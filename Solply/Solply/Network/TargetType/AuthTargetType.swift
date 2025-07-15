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
}

extension AuthTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .submitLogin: return .contentTypeJSON
        }
    }
    
    var path: String {
        switch self {
        case .submitLogin(let provider, _): return "/auth/social/\(provider)/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .submitLogin: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .submitLogin(_, let request): return .requestJSONEncodable(request)
        }
    }
}
