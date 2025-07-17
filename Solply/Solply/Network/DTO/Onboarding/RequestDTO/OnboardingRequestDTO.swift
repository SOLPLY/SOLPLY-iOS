//
//  OnboardingRequestDTO.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct OnboardingRequestDTO: RequestModelType {
    let selectedTownId: Int
    let favoriteTownIdList: [Int]
    let persona: String
    let nickname: String
}
