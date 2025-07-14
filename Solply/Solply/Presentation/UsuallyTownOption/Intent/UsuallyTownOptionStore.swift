//
//  UsuallyTownOptionStore.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

@MainActor
final class UsuallyTownOptionStore: ObservableObject {
    @Published private(set) var state = UsuallyTownOptionState()
    
    func dispatch(_ action: UsuallyTownOptionAction) {
        UsuallyTownOptionReducer.reduce(state: &state, action: action)
    }
}
