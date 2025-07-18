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
    case checkNickname(nickname: String)
    case fetchUserTowns
    case updateUserInfo(UserRequestDTO)
}

extension UserTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .accessToken
    }
    
    var path: String {
        switch self {
        case .fetchUserInformation:
            return "/users"
        case .checkNickname:
            return "/users/check-nickname"
        case .fetchUserTowns, .updateUserInfo:
            return "/users/towns"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUserInformation, .checkNickname, .fetchUserTowns:
            return .get
        case .updateUserInfo:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUserInformation:
            return .requestPlain
        case .checkNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: URLEncoding.queryString)
        
        case .fetchUserTowns:
            return .requestPlain
        
        case .updateUserInfo(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        }
    }
}
