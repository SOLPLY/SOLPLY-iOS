//
//  FrequentTownEffect.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct FrequentTownEffect {
    private let userService = UserService()
    
    func fetchTownList() async -> FrequentTownAction {
        do {
            let response = try await userService.fetchUserTowns()
            guard let data = response.data else {
                return .fetchFailure("데이터가 없습니다")
            }
            
            let towns = data.favoriteTownList.map { $0.toEntity() }
            let selected = data.selectedTown?.toEntity()
            
            return .fetchSuccess(selectedTown: selected, townList: towns)
        } catch {
            return .fetchFailure("동네 불러오기 실패")
        }
    }
    
    func saveTown(selectedTown: Town) async -> FrequentTownAction {
        do {
            let request = UserRequestDTO(
                selectedTownId: selectedTown.id,
                favoriteTownIdList: [selectedTown.id],
                persona: "",
                nickname: ""
            )
            _ = try await userService.updateUserInfo(request) 
            
            return .saveSuccess(selectedTown: selectedTown)
        } catch {
            return .saveFailure("저장 실패")
        }
    }
}
