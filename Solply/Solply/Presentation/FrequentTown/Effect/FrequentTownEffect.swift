//
//  FrequentTownEffect.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct FrequentTownEffect {
    private let townService = TownService()
    
    func fetchTownList() async -> OnboardingAction {
        do {
            let response = try await townService.fetchTownList()
            
            guard let data = response.data else {
                return .fetchTownFailure("데이터가 없습니다")
            }

            let towns = data.favoriteTownList.map { $0.toEntity() }

            guard let selected = data.selectedTown?.toEntity() else {
                return .fetchTownFailure("선택된 동네가 없습니다")
            }

            return .fetchTownSuccess(selectedTown: selected, townList: towns)
        } catch {
            return .fetchTownFailure("동네 불러오기 실패")
        }
    }
}
