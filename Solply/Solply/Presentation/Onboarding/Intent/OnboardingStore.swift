//
//  OnboardingStore.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import Foundation

@MainActor
final class OnboardingStore: ObservableObject {
    
    @Published private(set) var state = OnboardingState()
    
    func dispatch(_ action: OnboardingAction) {
        OnboardingReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
