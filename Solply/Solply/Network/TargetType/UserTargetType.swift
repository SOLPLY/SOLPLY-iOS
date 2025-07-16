//
//  UserTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum UserTargetType {
    case fetchUserInformation
}

extension UserTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .accessToken
    }
    
    var path: String {
        switch self {
        case .fetchUserInformation:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUserInformation: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUserInformation:
            return .requestPlain
        }
    }
    
    
}
