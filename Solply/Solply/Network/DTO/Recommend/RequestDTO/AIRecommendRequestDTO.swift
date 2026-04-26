//
//  AIRecommendRequestDTO.swift
//  Solply
//
//  Created by 김승원 on 4/26/26.
//

import Foundation

struct AIRecommendRequestDTO: RequestModelType {
    let query: String
    let townId: Int
}
