//
//  PlaceRecommendStore.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

@MainActor
final class PlaceRecommendStore: ObservableObject {
    @Published private(set) var state = PlaceRecommendState()
    
    func dispatch(_ action: PlaceRecommendAction) {
//        PlaceRecommendReducer.reduce(state: &state, action: action)
//
//        switch action {
//        default:
//            break
//        }
    }
}
