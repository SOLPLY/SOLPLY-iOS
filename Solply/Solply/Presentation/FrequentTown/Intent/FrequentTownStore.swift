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
    private let effect = FrequentTownEffect()
    
    func dispatch(_ action: FrequentTownAction) {
        FrequentTownReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchTown:
            fetchTownList()
            
        case .saveTown:
            saveSelectedTown()
            
        default:
            break
        }
    }
    
    private func fetchTownList() {
        Task {
            let result = await effect.fetchTownList()
            dispatch(result)
        }
    }
    
    private func saveSelectedTown() {
        guard let selectedTown = state.selectedTown else {
            print("❗️ 선택된 동네가 없습니다.")
            return
        }
        
        Task {
            let result = await effect.saveTown(selectedTown: selectedTown)
            dispatch(result)
        }
    }
}
