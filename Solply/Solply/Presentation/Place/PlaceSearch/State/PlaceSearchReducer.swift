//
//  PlaceSearchReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

enum PlaceSearchReducer {
    @MainActor static func reduce(state: inout PlaceSearchState, action: PlaceSearchAction) {
        switch action {
        case .searchPlace:
            state.isSearchLoading = true
            break
            
        case .searchPlaceSuccess(let places):
            state.searchedPlaces = places
            state.isSearchCompleted = true
            state.isSearchLoading = false
            
        case .searchPlaceFailed(let error):
            state.isSearchCompleted = true
            state.searchedPlaces = []
            state.isSearchLoading = false
            print(error)
            break
            
        case .searchQueryLengthInvalid:
            state.isSearchLoading = false
        }
    }
}
