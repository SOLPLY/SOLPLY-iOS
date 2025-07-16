//
//  ArchiveReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import Foundation

enum ArchiveReducer {
    static func reduce(state: inout ArchiveState, action: ArchiveAction) {
        switch action {
        case .toggleArchiveBar(let archiveCategory):
            state.selectedCategory = archiveCategory
            
        case .fetchPlaceThumbnail:
            break
            
        case .placeThumbnailFetched:
            break
            
        case .errorOccured(let error):
            print(error)
            break
        }
    }
}
