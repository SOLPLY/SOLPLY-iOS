//
//  MySolplyRecordsStore.swift
//  Solply
//
//  Created by 김승원 on 4/18/26.
//

import Foundation

@MainActor
final class MySolplyRecordsStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = MySolplyRecordsState()
    
    // MARK: - Dispatch
    
    func dispatch(_ action: MySolplyRecordsAction) {
        MySolplyRecordsReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
