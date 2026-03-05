//
//  TagsTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum TagsTargetType {
    case fetchMainTags
    case fetchSubTags(tagUsage: String, parentId: Int)
}

extension TagsTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .contentTypeJSON
    }
    
    var path: String {
        switch self {
        case .fetchMainTags:
            return "/tags"
        case .fetchSubTags:
            return "/tags"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMainTags: return .get
        case .fetchSubTags: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMainTags:
            return .requestPlain
            
        case .fetchSubTags(let tagUsage, let parentId):
            let params: [String: Any] = [
                "tagUsage": tagUsage,
                "parentId": parentId
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
