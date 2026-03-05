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
                return .fetchTownsFailure(error: .responseError)
            }
            
            let towns = data.toEntity()
            
            return .fetchTownsSuccess(townList: towns)
        } catch let error as NetworkError {
            return .fetchTownsFailure(error: error)
        } catch {
            return .fetchTownsFailure(error: .unknownError)
        }
    }

    func saveSelection(selectedTownId: Int) async -> JGDAction {
        do {
            
            let request = UserTownsUpdateRequestDTO(
                selectedTownId: selectedTownId
            )
            
            _ = try await userService.updateUserTowns(request)
            
            return .saveSelectionSuccess
        } catch let error as NetworkError {
            return .saveSelectionFailure(error: error)
        } catch {
            return .saveSelectionFailure(error: .unknownError)
        }
    }
}
