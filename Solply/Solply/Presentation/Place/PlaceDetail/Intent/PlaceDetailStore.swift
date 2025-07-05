//
//  PlaceDetailStore.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

@MainActor
final class PlaceDetailStore: ObservableObject {
    @Published private(set) var state = PlaceDetailState()
    
    func dispatch(_ action: PlaceDetailAction) {
        PlaceDetailReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
