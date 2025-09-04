//
//  OnboardingTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum OnboardingTargetType {
    case fetchPersonaList
    case completeOnboarding(OnboardingCompleteRequestDTO)
}

extension OnboardingTargetType: BaseTargetType {
    
    var headerType: HTTPHeader {
        return .accessToken
    }
    
    var path: String {
        switch self {
        case .fetchPersonaList:
            return "/onboarding/questions/persona"
        case .completeOnboarding:
            return "/onboarding/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .completeOnboarding:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPersonaList:
            return .requestPlain
        case .completeOnboarding(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        }
    }
}
