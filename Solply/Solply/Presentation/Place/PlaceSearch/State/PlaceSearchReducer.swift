//
//  PlaceSearchReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

struct PlaceSearchReducer {
    @MainActor static func reduce(state: inout PlaceSearchState, action: PlaceSearchAction) {
        switch action {
        case .searchPlace:
            state.isSearchCompleted = false
        case .placeSearched(let places):
            state.places = places
            state.isSearchCompleted = true
        case .errorOccured(let error):
            state.isSearchCompleted = true
            print(error)
            break
        }
    }
}
