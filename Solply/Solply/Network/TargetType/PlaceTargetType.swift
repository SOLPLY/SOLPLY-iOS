//
//  PlaceTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum PlaceTargetType {
    case fetchPlaceThumbnail
    case submitPlaceBookmark(placeId: Int)
    case removePlaceBookmark(placeId: Int)
    case fetchPlaceDetail(placeId: Int)
    case fetchPlaceRecommend(townId: Int)
}

extension PlaceTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .fetchPlaceThumbnail: return .accessToken
        case .submitPlaceBookmark: return .accessToken
        case .removePlaceBookmark: return .accessToken
        case .fetchPlaceDetail: return .accessToken
        case .fetchPlaceRecommend: return .accessToken
        }
    }
    
    var path: String {
        switch self {
        case .fetchPlaceThumbnail:
            return "/places/bookmarks/folders/preview"
        case .submitPlaceBookmark(placeId: let placeId):
            return "/places/\(placeId)/bookmarks"
        case .removePlaceBookmark(placeId: let placeId):
            return "/places/\(placeId)/bookmarks"
        case .fetchPlaceDetail(placeId: let placeId):
            return "/places/\(placeId)"
        case .fetchPlaceRecommend:
            return "/recommend/places"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceThumbnail: return .get
        case .submitPlaceBookmark: return .post
        case .removePlaceBookmark: return .delete
        case .fetchPlaceDetail: return .get
        case .fetchPlaceRecommend: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPlaceThumbnail:
            return .requestPlain
        case .submitPlaceBookmark:
            return .requestPlain
        case .removePlaceBookmark:
            return .requestPlain
        case .fetchPlaceDetail:
            return .requestPlain
        case .fetchPlaceRecommend(let townId):
            let params: [String: Any] = ["townId": townId]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
