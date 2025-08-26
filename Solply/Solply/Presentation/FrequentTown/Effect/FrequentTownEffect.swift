//
//  FrequentTownEffect.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct FrequentTownEffect {
    private let userService: UserAPI
    
    init(
        userService: UserAPI
    ) {
        self.userService = userService
    }
    
    func fetchTownList() async -> FrequentTownAction {
        do {
            let response = try await userService.fetchUserTowns()
            guard let data = response.data else {
                return .fetchFailure("데이터가 없습니다")
            }
            
            let towns = data.favoriteTownList.map { $0.toEntity() }
            
            let selected = data.selectedTown.toEntity()
            
            print("📥 [FetchTownList] 가져온 동네 리스트: \(towns.map { $0.name })")
            print("🏠 [FetchTownList] 선택된 동네: \(selected.name)")
            
            return .fetchSuccess(selectedTown: selected, townList: towns)
        } catch {
            return .fetchFailure("동네 불러오기 실패")
        }
    }
    
    func saveTown(selectedTown: Town, favoriteTownList: [Town]) async -> FrequentTownAction {
        do {
            let request = UserTownsUpdateRequestDTO(
                selectedTownId: selectedTown.id,
                favoriteTownIdList: favoriteTownList.map { $0.id }
            )
            _ = try await userService.updateUserTowns(request)
            
            print("✅ [SaveTown] 저장 완료 - 선택된 동네: \(selectedTown.name)")
            print("✅ [SaveTown] 저장 완료 - 즐겨찾는 동네 목록: \(favoriteTownList.map { $0.name })")
            
            return .saveSuccess(selectedTown: selectedTown)
        } catch {
            return .saveFailure("동네 저장 실패")
        }
    }
}
