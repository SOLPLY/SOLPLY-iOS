//
//  WithdrawStore.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import Foundation

@MainActor
final class WithdrawStore: ObservableObject {
    
    @Published private(set) var state = WithdrawState()
    private let effect = WithdrawEffect()
    
    func dispatch(_ action: WithdrawAction) {
        WithdrawReducer.reduce(state: &state, action: action)
        
        switch action {
        
        default:
            break
        }
    }
}
