//
//  JGDEffect.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

struct JGDEffect {
    private let userService: UserAPI
    private let townService: TownAPI

    init(userService: UserAPI, townService: TownAPI) {
        self.userService = userService
        self.townService = townService
    }
    
    func fetchTowns() async -> JGDAction {
        do {
            let response = try await townService.fetchTownList()
            
            guard let data = response.data else {
                return .fetchTownsFailure("데이터가 없습니다.")
            }
            
            let towns = data.toEntity()
            
            return .fetchTownsSuccess(townList: towns)
        } catch {
            return .fetchTownsFailure("동네 불러오기 실패")
        }
    }

    func saveSelection(selectedTown: Town, selectedSubTown: SubTown) async -> JGDAction {
        do {
            let request = UserTownsUpdateRequestDTO(
                selectedTownId: selectedTown.id,
                favoriteTownIdList: [selectedSubTown.id]
            )
            
            _ = try await userService.updateUserTowns(request)
            
            return .saveSelectionSuccess(
                selectedTown: selectedTown,
                selectedSubTown: selectedSubTown
            )
        } catch {
            return .saveSelectionFailure("동네 저장 실패: \(error.localizedDescription)")
        }
    }
}
