//
//  JGDAction.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

enum JGDAction {
    case fetchTowns
    case fetchTownsSuccess(townList: [Town])
    case fetchTownsFailure(String)
    
    case setInitialTownId(townId: Int)
    
    case selectTown(Town)
    case selectSubTown(SubTown)
    
    case saveSelection(selectedTown: Town, selectedSubTown: SubTown)
    case saveSelectionSuccess(selectedTown: Town, selectedSubTown: SubTown)
    case saveSelectionFailure(String)
}
