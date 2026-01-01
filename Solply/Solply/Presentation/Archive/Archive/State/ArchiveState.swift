//
//  ArchiveState.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import Foundation

struct ArchiveState {
    var isPlaceFolderLoading: Bool = false
    var isCourseFolderLoading: Bool = false
    
    var selectedCategory: SolplyContentType = .place
    
    var PlacefolderList : [PlaceArchiveThumbnailDTO] = []
    var CourseFolderList: [CourseArchiveThumbnailDTO] = []
}
