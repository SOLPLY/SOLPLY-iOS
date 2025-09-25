//
//  ReportsEffect.swift
//  Solply
//
//  Created by 김승원 on 9/25/25.
//

import Foundation

struct ReportsEffect {
    // TODO: - Service 추후 추가 예정
    
}

// MARK: - Functions

extension ReportsEffect {
    func waitForLottie() async -> ReportsAction {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return .endLottie
    }
}
