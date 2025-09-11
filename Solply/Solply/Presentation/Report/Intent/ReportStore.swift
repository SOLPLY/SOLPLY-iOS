//
//  ReportStore.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

@MainActor
final class ReportStore: ObservableObject {
    @Published private(set) var state = ReportState()
    
    func dispatch(_ action: ReportAction) {
        ReportReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
