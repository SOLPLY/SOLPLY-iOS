//
//  PlaceSearchStore.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import Foundation

@MainActor
final class PlaceSearchStore: ObservableObject {
    @Published private(set) var state = PlaceSearchState()
    private let effect : PlaceSearchEffect =
        PlaceSearchEffect(placeService: PlaceService())
    
    func dispatch(_ action: PlaceSearchAction) {
        PlaceSearchReducer.reduce(state: &state, action: action)
        
        switch action {
        case .searchPlace(let placeName):
            if placeName.count > 1 {
                Task {
                    let result = await effect.searchPlace(placeName: placeName)
                    self.dispatch(result)
                }
            } else {
                self.dispatch(.searchQueryLengthInvalid)
            }
            
        case .searchPlaceSuccess(let places):
            AmplitudeManager.shared.track(.viewSearchResult(isEmpty: places.isEmpty))
        
        default:
            break
        }
    }
}
