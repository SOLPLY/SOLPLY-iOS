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
    case removePlaceList(placeIds: [Int])
    case fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool,
        mainTagId: Int?,
        subTagAIdList: [Int]?,
        subTagBIdList: [Int]?
    )
}

extension PlaceTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .accessToken
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
        case .removePlaceList(placeIds: _):
            return "/places/bookmarks/"
        case .fetchPlaceList:
            return "/places"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceThumbnail: return .get
        case .submitPlaceBookmark: return .post
        case .removePlaceBookmark: return .delete
        case .fetchPlaceDetail: return .get
        case .fetchPlaceRecommend: return .get
        case .removePlaceList: return .delete
        case .fetchPlaceList: return .get
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
        case .removePlaceList(let placeIds):
            let joinedPlaceIds = placeIds.map { String($0) }.joined(separator: ",")
            let params: [String: Any] = ["placeIds": joinedPlaceIds]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .fetchPlaceList(
            let townId,
            let isBookmarkSearch,
            let mainTagId,
            let subTagAIdList,
            let subTagBIdList
        ):
            var params: [String: Any] = [
                "townId": townId,
                "isBookmarkSearch": isBookmarkSearch
            ]
            
            // mainTagId가 nil이 아닌 경우에만 추가
            if let mainTagId = mainTagId {
                params["mainTagId"] = mainTagId
            }
            
            // subTagAIdList가 nil이 아니고 비어있지 않은 경우
            if let subTagAIdList = subTagAIdList, !subTagAIdList.isEmpty {
                params["subTagAIdList"] = subTagAIdList.map { String($0) }.joined(separator: ",")
            }
            
            // subTagBIdList가 nil이 아니고 비어있지 않은 경우
            if let subTagBIdList = subTagBIdList, !subTagBIdList.isEmpty {
                params["subTagBIdList"] = subTagBIdList.map { String($0) }.joined(separator: ",")
            }
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
