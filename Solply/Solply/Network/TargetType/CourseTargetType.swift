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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCourseArchive: return .get
        case .fetchCourseDetail: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCourseArchive(let townId, let placeId):
            var params: [String: Any] = ["townId": townId]
            
            // placeId를 서버에서 nullable하게 받음
            if let placeId = placeId {
                params["placeId"] = placeId
            }
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .fetchCourseDetail:
            return .requestPlain
        }
    }
}
