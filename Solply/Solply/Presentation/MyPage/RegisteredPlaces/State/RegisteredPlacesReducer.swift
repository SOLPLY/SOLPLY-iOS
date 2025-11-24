//
//  RegisteredPlacesReducer.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import Foundation

enum RegisteredPlacesReducer {
    static func reduce(state: inout RegisteredPlacesState, action: RegisteredPlacesAction) {
        switch action {
        case .fetchRegisteredPlaces:
            break
        case .registeredPlacesLoaded(let places):
            state.registeredPlaces = places
        case .registeredPlacesLoadFailed(let error):
            state.error = error
        }
    }
}
