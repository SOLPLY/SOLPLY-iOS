//
//  FileTargetType.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

import Moya

enum FileTargetType {
    case submitPresignedUrlRequest(request: PresignedUrlRequestDTO)
}

extension FileTargetType: BaseTargetType {
    var headerType: HTTPHeader {
        return .contentTypeJSON
    }
    
    var path: String {
        switch self {
        case .submitPresignedUrlRequest:
            return "/files/presigned-urls"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .submitPresignedUrlRequest:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .submitPresignedUrlRequest(let request):
            return .requestJSONEncodable(request)
        }
    }
}
