//
//  AuthTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

enum AuthTargetType {
    case login(provider: String, request: AuthLoginRequestDTO)
}

extension AuthTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .login: return .contentTypeJSON
        }
    }
    
    var path: String {
        switch self {
        case .login(let provider, _): return "/auth/social/\(provider)/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(_, let request): return .requestJSONEncodable(request)
        }
    }
}
