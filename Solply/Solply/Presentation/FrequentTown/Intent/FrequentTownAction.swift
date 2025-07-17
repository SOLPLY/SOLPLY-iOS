//
//  FrequentTownAction.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

enum FrequentTownAction {
    case fetchTownList
    case fetchSuccess(selectedTown: Town?, townList: [Town])
    case fetchFailure(message: String)
    
    case selectTown(Town)
}
