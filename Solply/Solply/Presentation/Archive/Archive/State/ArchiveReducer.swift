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
            
        case .placeThumbnailFetched(let placeArchiveThumbnails):
            state.folderThumbnailList = placeArchiveThumbnails
            print(placeArchiveThumbnails)
            
        case .fetchCourseThumbnail:
            break
            
        case .courseThumbnailFetched(let courseArchiveTumbnails):
            state.folders = courseArchiveTumbnails
            print(courseArchiveTumbnails)
            
        case .errorOccured(let error):
            print(error)
            break
        }
    }
}
