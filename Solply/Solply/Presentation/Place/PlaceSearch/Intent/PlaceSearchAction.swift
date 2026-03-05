//
//  PlaceSearchAction.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

enum PlaceSearchAction {
    case searchPlace(placeName: String)
    case searchPlaceSuccess(places: [PlaceSearchDTO])
    case searchPlaceFailed(error: NetworkError)
    case searchQueryLengthInvalid
}
