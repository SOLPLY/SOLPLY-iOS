//
//  OnboardingCompleteRequestDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct OnboardingCompleteRequestDTO: RequestModelType {
    let selectedTownId: Int
    let favoriteTownIdList: [Int]
    let persona: String
    let nickname: String
}
