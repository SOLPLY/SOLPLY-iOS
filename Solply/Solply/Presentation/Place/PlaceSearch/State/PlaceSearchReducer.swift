//
//  PlaceSearchReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

struct PlaceSearchReducer {
    static func reduce(state: inout placeSearchState, action: OnClickSearchIcon) {
        switch action {
        case .searchPlace(let placeName):
            state.placeName = placeName
        }
    }
}
