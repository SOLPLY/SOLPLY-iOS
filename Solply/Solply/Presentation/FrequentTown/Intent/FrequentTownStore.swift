//
//  FrequentTownStore.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

@MainActor
final class FrequentTownStore: ObservableObject {
    
    @Published private(set) var state = FrequentTownState()
    
    func dispatch(_ action: FrequentTownAction) {
        FrequentTownReducer.reduce(state: &state, action: action)
    }
}
