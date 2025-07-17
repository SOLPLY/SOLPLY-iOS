//
//  TownTargetType.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

import Moya

enum TownTargetType: BaseTargetType {
    case fetchTownList
    
    var headerType: HTTPHeader { .accessToken }
    var path: String { "/users/towns" }
    var method: Moya.Method { .get }
    var task: Task { .requestPlain }
}
