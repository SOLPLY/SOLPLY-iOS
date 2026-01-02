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
            state.isPlaceFolderLoading = true
            break
            
        case .placeThumbnailFetched(let placeArchiveThumbnails):
            state.PlacefolderList = placeArchiveThumbnails
            state.isPlaceFolderLoading = false
            print(placeArchiveThumbnails)
            
        case .fetchPlaceThumbnailFailed(let error):
            state.isPlaceFolderLoading = true
            print(error)
            break
            
        case .fetchCourseThumbnail:
            state.isCourseFolderLoading = true
            break
            
        case .courseThumbnailFetched(let courseArchiveThumbnails):
            state.CourseFolderList = courseArchiveThumbnails
            state.isCourseFolderLoading = false
            print(courseArchiveThumbnails)
            
        case .fetchCourseThumbnailFailed(let error):
            state.isCourseFolderLoading = true
            print(error)
            break
        }
    }
}
