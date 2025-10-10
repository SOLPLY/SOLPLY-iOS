//
//  PlaceSearchAction.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

enum PlaceSearchAction {
    case searchPlace(placeName: String)
    case placeSearched(places: [PlaceSearchDTO])
    case errorOccured(error: NetworkError)
}
