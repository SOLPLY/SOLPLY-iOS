//
//  JGDStore.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

@MainActor
final class JGDStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = JGDState()
    
    private let effect = JGDEffect(
        userService: UserService(),
        townService: TownService()
    )
    
    // MARK: - Intent
    
    func dispatch(_ action: JGDAction) {
        JGDReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchTopTowns:
            Task {
                let result = await effect.fetchTopTowns()
                dispatch(result)
            }
            
        case .saveSelection(let selectedTop, let selectedSub):
            Task {
                let result = await effect.saveSelection(
                    selectedTopTown: selectedTop,
                    selectedSubTown: selectedSub
                )
                dispatch(result)
            }
            
        default:
            break
        }
    }
}

