//
//  ArchiveListStore.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

@MainActor
final class ArchiveListStore: ObservableObject {
    @Published private(set) var state = ArchiveListState()
    
    func dispatch(_ action: ArchiveListAction) {
        ArchiveListReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
