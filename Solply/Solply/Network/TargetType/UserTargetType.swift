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
    case updateUserTowns(UserTownsUpdateRequestDTO)
    
    case fetchPersonaList
    case fetchPolicies
    case completeOnboarding(UserCompleteRequestDTO)
}

extension UserTargetType: BaseTargetType {
    
    var headerType: HTTPHeader {
        return .contentTypeJSON
    }
    
    var path: String {
        switch self {

        case .fetchUserInformation:
            return "/users"
        case .checkNickname:
            return "/users/check-nickname"
        case .fetchUserTowns, .updateUserTowns:
            return "/users/towns"
            
        case .fetchPersonaList:
            return "/users/persona"
        case .fetchPolicies:
            return "/users/policies"
        case .completeOnboarding:
            return "/users/onboarding"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateUserTowns, .completeOnboarding:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {

        case .fetchUserInformation, .fetchUserTowns, .fetchPersonaList, .fetchPolicies:
            return .requestPlain
            
        case .checkNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname],
                                      encoding: URLEncoding.queryString)
            
        case .updateUserTowns(let requestDTO):
            return .requestJSONEncodable(requestDTO)
            
        case .completeOnboarding(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        }
    }
}
