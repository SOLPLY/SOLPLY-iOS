//
//  JGDAction.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

enum JGDAction {
    case fetchTowns
    case fetchTownsSuccess(townList: [Town])
    case fetchTownsFailure(error: NetworkError)
    
    case setInitialTownId(townId: Int)
    
    case selectTown(Town)
    case selectSubTown(SubTown)
    
    case saveSelection
    case saveSelectionSuccess
    case saveSelectionFailure(error: NetworkError)
}
