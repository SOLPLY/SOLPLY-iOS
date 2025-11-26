//
//  RegisteredPlacesAction.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import Foundation

enum RegisteredPlacesAction {
    case fetchRegisteredPlaces(userId: Int, page: Int = 0, size: Int = 100)
    case registeredPlacesFetched([RegisteredPlace])
    case fetchRegisteredPlacesFailed(error: NetworkError)
}
