//
//  UserTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum UserTargetType {
    case checkNickname(nickname: String)
}

extension UserTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .accessToken
    }
    
    var path: String {
        switch self {
        case .checkNickname:
            return "/users/check-nickname"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkNickname:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .checkNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: URLEncoding.queryString)
        }
    }
}
