//
//  RegisteredPlacesAction.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import Foundation

enum RegisteredPlacesAction {
    case fetchRegisteredPlaces(userId: Int, page: Int = 1, size: Int = 3)
    case registeredPlacesLoaded([RegisteredPlace])
    case registeredPlacesLoadFailed(error: NetworkError)
}
