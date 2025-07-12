//
//  ArchiveStore.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import Foundation

@MainActor
final class ArchiveStore: ObservableObject {
    @Published private(set) var state = ArchiveState()
    
    func dispatch(_ action: ArchiveAction) {
        ArchiveReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}

