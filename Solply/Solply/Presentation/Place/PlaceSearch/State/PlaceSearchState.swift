//
//  PlaceSearchState.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

struct PlaceSearchState {
    var placeName: String = ""
    var searchedPlaces: [PlaceSearchDTO] = []
    var isSearchCompleted: Bool = false
    var isSearchLoading: Bool = false
}
