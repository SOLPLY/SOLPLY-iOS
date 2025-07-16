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
}

extension PlaceTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .fetchPlaceThumbnail: return .accessToken
        case .submitPlaceBookmark: return .accessToken
        case .removePlaceBookmark: return .accessToken
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceThumbnail: return .get
        case .submitPlaceBookmark: return .post
        case .removePlaceBookmark: return .delete
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
        }
    }
}
