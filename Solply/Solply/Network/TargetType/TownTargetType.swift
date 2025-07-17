//
//  TownTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//
//

import Foundation

import Moya

enum TownTargetType {
    case fetchTownList
}

extension TownTargetType: BaseTargetType {
    
    var headerType: HTTPHeader {
        return .accessToken
    }
    
    var path: String {
        switch self {
        case .fetchTownList:
            return "/users/towns"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
}
