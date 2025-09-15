//
//  BaseTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {
    var headerType: HTTPHeader { get }
}

extension BaseTargetType {
    var baseURL: URL {
        guard let url = URL(string: "\(AppEnvironment.baseURL)/api") else {
            fatalError("Error: BaseURL을 찾을 수 없습니다.")
        }
        
        return url
    }
    
    var headers: [String: String]? {
        var header = ["Content-Type": "application/json"]
        
        switch headerType {
        case .contentTypeJSON:
            break
            
        case .refreshToken(let refreshToken):
            header["Refresh-Token"] = refreshToken
        }
        
        return header
    }
}

enum HTTPHeader {
    case contentTypeJSON
    case refreshToken(String)
}
