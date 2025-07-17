//
//  FrequentTownStore.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

@MainActor
final class FrequentTownStore: ObservableObject {
    @Published var state = OnboardingState() // 일단은 OnboardingState 사용
    private let effect = FrequentTownEffect()
    
    func dispatch(_ action: OnboardingAction) {
        OnboardingReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchTown:
            Task {
                let result = await effect.fetchTownList()
                dispatch(result)
            }
            
        case .fetchTownSuccess, .fetchTownFailure, .selectTown:
            break
            
        default:
            break
        }
    }
}
