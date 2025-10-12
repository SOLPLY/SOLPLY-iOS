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

    func fetchTopTowns() async -> JGDAction {
        do {
            let response = try await townService.fetchTownList()
            guard let data = response.data else {
                return .fetchTopTownsFailure("데이터가 없습니다.")
            }

            let topTowns: [TopTown] = data.towns.map { top in
                TopTown(
                    id: top.townId,
                    name: top.townName,
                    subTowns: (top.subTowns ?? []).map { sub in
                        Town(id: sub.townId, name: sub.displayName)
                    }
                )
            }

            return .fetchTopTownsSuccess(topTownList: topTowns)
        } catch {
            return .fetchTopTownsFailure("동네 불러오기 실패")
        }
    }

    func saveSelection(selectedTopTown: TopTown, selectedSubTown: Town) async -> JGDAction {
        do {
            let request = UserTownsUpdateRequestDTO(
                selectedTownId: selectedSubTown.id,
                favoriteTownIdList: []
            )
            _ = try await userService.updateUserTowns(request)
            return .saveSelectionSuccess(
                selectedTopTown: selectedTopTown,
                selectedSubTown: selectedSubTown
            )
        } catch {
            return .saveSelectionFailure("동네 저장 실패")
        }
    }
}
