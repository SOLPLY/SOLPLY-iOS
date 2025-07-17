//
//  CourseTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum CourseTargetType {
    case fetchCourseArchive(townId: Int, placeId: Int?)
    case fetchCourseDetail(courseId: Int)
    case submitCourseBookmark(courseId: Int)
    case removeCourseBookmark(courseId: Int)
    case fetchCourseThumbnail
    case removeCourseList(courseIds: [Int])
    case fetchCourseRecommend(townId: Int)
    case submitAddPlace(courseId: Int, placeId: Int)
}

extension CourseTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .accessToken // 고정
    }
    
    var path: String {
        switch self {
        case .fetchCourseArchive:
            return "/courses/bookmarks"
        case .fetchCourseDetail(courseId: let courseId):
            return "/courses/\(courseId)"
        case .submitCourseBookmark(courseId: let courseId):
            return "/courses/\(courseId)/bookmarks"
        case .removeCourseBookmark(courseId: let courseId):
            return "/courses/\(courseId)/bookmarks"
        case .fetchCourseThumbnail:
            return "/courses/bookmarks/folders"
        case .removeCourseList(courseIds: _):
            return "/courses/bookmarks"
        case .fetchCourseRecommend:
            return "/recommend/courses"
        case .submitAddPlace(courseId: let courseId, placeId: let placeId):
            return "/courses/\(courseId)/places/\(placeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCourseArchive: return .get
        case .fetchCourseDetail: return .get
        case .submitCourseBookmark: return .post
        case .removeCourseBookmark: return .delete
        case .fetchCourseThumbnail: return .get
        case .removeCourseList: return .delete
        case .fetchCourseRecommend: return .get
        case .submitAddPlace: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCourseArchive(let townId, let placeId):
            var params: [String: Any] = ["townId": townId]
            
            // placeId를 서버에서 nullable하게 받음
            if let placeId = placeId {
                params["candidatePlaceId"] = placeId
            }
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .fetchCourseDetail:
            return .requestPlain
            
        case .submitCourseBookmark:
            return .requestPlain
            
        case .removeCourseBookmark:
            return .requestPlain
            
        case .fetchCourseThumbnail:
            return .requestPlain
            
        case .removeCourseList(let courseIds):
            let joinedCourseIds = courseIds.map { String($0) }.joined(separator: ",")
            let params: [String: Any] = ["courseIds": joinedCourseIds]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .fetchCourseRecommend(let townId):
            let params: [String: Any] = ["townId": townId]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .submitAddPlace:
            return .requestPlain
        }
    }
}
