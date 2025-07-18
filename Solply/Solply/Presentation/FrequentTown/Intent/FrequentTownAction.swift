//
//  FrequentTownAction.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

enum FrequentTownAction {
    case fetchTown
    case fetchSuccess(selectedTown: Town?, townList: [Town])
    case fetchFailure(String)

    case selectTown(Town)

    case saveTown
    case saveSuccess(selectedTown: Town)
    case saveFailure(String)
}
