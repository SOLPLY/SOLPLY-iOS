//
//  ArchiveListReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

enum ArchiveListReducer {
    static func reduce(state: inout ArchiveListState, action: ArchiveListAction) {
        switch action {
        case .toggleArchiveList(let index):
            if state.selectedIndex.contains(index) {
                state.selectedIndex.remove(index)
            } else {
                state.selectedIndex.insert(index)
            }
            
        case .toggleSelect:
            state.activeDelete = true
            
        case .toggleCancel:
            state.selectedIndex.removeAll()
            state.activeDelete = false
        }
    }
}
