//
//  RecommendTargetType.swift
//  Solply
//
//  Created by seozero on 8/20/25.
//

import Foundation

import Moya

enum RecommendTargetType {
    case fetchPlaceRecommend(townId: Int)
    case fetchCourseRecommend(townId: Int)
}

extension RecommendTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .contentTypeJSON
    }
    
    var path: String {
        switch self {
        case .fetchPlaceRecommend:
            return "/recommend/places"
        case .fetchCourseRecommend:
            return "/recommend/courses"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceRecommend: return .get
        case .fetchCourseRecommend: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPlaceRecommend(let townId):
            let params: [String: Any] = ["townId": townId]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .fetchCourseRecommend(let townId):
            let params: [String: Any] = ["townId": townId]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
