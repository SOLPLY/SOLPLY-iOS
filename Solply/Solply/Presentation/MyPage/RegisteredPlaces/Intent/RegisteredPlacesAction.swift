//
//  RegisteredPlacesAction.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import Foundation

enum RegisteredPlacesAction {
    case fetchRegisteredPlaces(userId: Int, page: Int, size: Int)
    case registeredPlacesFetched([RegisteredPlace])
    case fetchRegisteredPlacesFailed(error: NetworkError)
}
