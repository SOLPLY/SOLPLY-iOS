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
}

extension PlaceTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        switch self {
        case .fetchPlaceThumbnail: return .accessToken
        }
    }
    
    var path: String {
        switch self {
        case .fetchPlaceThumbnail:
            return "/places/bookmarks/folders/preview"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceThumbnail: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPlaceThumbnail:
            return .requestPlain
        }
    }
}
