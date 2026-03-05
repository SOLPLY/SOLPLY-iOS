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
    case fetchRegisteredPlaces(userId: Int, page: Int, size: Int)
    case checkNickname(nickname: String)
    case fetchUserTowns
    case updateUserTowns(UserTownsUpdateRequestDTO)
    case updateUserInformation(request: UpdateUserInformationRequestDTO)
    
    case fetchPersonaList
    case fetchPolicies
    case completeOnboarding(UserCompleteRequestDTO)
    case withdraw(UserWithdrawRequestDTO)
}

extension UserTargetType: BaseTargetType {
    
    var headerType: HTTPHeader {
        return .contentTypeJSON
    }
    
    var path: String {
        switch self {
            
        case .fetchUserInformation, .updateUserInformation:
            return "/users"
        case let .fetchRegisteredPlaces(userId, _, _):
            return "/users/\(userId)/places"
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
        case .withdraw:
            return "/users/withdraw"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateUserTowns, .completeOnboarding, .updateUserInformation:
            return .patch
        case .withdraw:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .fetchUserInformation, .fetchUserTowns, .fetchPersonaList, .fetchPolicies:
            return .requestPlain
            
        case let .fetchRegisteredPlaces(_, page, size):
            return .requestParameters(
                parameters: ["page": page, "size": size],
                encoding: URLEncoding.queryString
            )
            
        case .checkNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname],
                                      encoding: URLEncoding.queryString)
            
        case .updateUserTowns(let requestDTO):
            return .requestJSONEncodable(requestDTO)
            
        case .updateUserInformation(let request):
            return .requestJSONEncodable(request)
            
        case .completeOnboarding(let requestDTO):
            return .requestJSONEncodable(requestDTO)
            
        case .withdraw(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        }
    }
}
