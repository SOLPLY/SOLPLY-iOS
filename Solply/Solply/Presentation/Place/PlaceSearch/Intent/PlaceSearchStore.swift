//
//  PlaceSearchStore.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

@MainActor
final class PlaceSearchStore: ObservableObject {
    @Published private(set) var state = searchState()
    
    func dispatch(_ action: OnClickSearchIcon) {
        PlaceSearchReducer.reduce(state: &state, action: action)
    }
}
