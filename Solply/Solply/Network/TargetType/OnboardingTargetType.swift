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
        return .contentTypeJSON
    }
    
    var path: String {
        switch self {
        case .fetchPersonaList:
            return "/users/persona"
        case .completeOnboarding:
            return "/users/onboarding"
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
