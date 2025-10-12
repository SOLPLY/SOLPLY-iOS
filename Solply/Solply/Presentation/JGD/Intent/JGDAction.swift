//
//  JGDAction.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

enum JGDAction {
    case fetchTopTowns
    case fetchTopTownsSuccess(topTownList: [TopTown])
    case fetchTopTownsFailure(String)

    case selectTopTown(TopTown)
    case selectSubTown(Town)

    case saveSelection(selectedTopTown: TopTown, selectedSubTown: Town)
    case saveSelectionSuccess(selectedTopTown: TopTown, selectedSubTown: Town)
    case saveSelectionFailure(String)
}

