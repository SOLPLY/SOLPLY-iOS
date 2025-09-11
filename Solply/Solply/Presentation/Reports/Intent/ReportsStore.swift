//
//  ReportsStore.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

@MainActor
final class ReportsStore: ObservableObject {
    @Published private(set) var state = ReportsState()
    
    func dispatch(_ action: ReportsAction) {
        ReportsReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
