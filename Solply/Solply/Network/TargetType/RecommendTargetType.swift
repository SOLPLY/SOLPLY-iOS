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
    case submitAIPlaceRecommend(request: AIRecommendRequestDTO)
    case submitAICourseRecommend(request: AIRecommendRequestDTO)
    case fetchAIExamplePhrases(type: String)
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
        case .submitAIPlaceRecommend:
            return "/recommend/places/embedding"
        case .submitAICourseRecommend:
            return "/recommend/courses/embedding"
        case .fetchAIExamplePhrases:
            return "/recommend/example-phrases"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceRecommend: return .get
        case .fetchCourseRecommend: return .get
        case .submitAIPlaceRecommend: return .post
        case .submitAICourseRecommend: return .post
        case .fetchAIExamplePhrases: return .get
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
        case .submitAIPlaceRecommend(let request):
            return .requestJSONEncodable(request)
        case .submitAICourseRecommend(let request):
            return .requestJSONEncodable(request)
        case .fetchAIExamplePhrases(let type):
            let params: [String: Any] = ["type": type]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
