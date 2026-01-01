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
            state.PlacefolderList = placeArchiveThumbnails
            print(placeArchiveThumbnails)
            
        case .fetchPlaceThumbnailFailed(let error):
            print(error)
            break
            
        case .fetchCourseThumbnail:
            break
            
        case .courseThumbnailFetched(let courseArchiveThumbnails):
            state.CourseFolderList = courseArchiveThumbnails
            print(courseArchiveThumbnails)
            
        case .fetchCourseThumbnailFailed(let error):
            print(error)
            break
        }
    }
}
