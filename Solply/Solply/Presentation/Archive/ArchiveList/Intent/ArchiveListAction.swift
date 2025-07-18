//
//  ArchiveListAction.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

enum ArchiveListAction {
    case toggleCourseArchiveList(courseId: Int)
    case togglePlaceArchiveList(placeId: Int)
    case toggleSelect
    case toggleCancel
    
    case showAlert
    case alertCancel
    case alertDelete
    
    // api
    case fetchCourseList(townId: Int, placeId: Int?)
    case courseListFetched(courseLists: [CourseArchiveDTO])
    
    case fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool,
        mainTagId: Int?,
        subTagAIdList: [Int]?,
        subTagBIdList: [Int]?
    )
    case placeListFetched([PlaceDTO])
    
    case removeCourseList(CourseIds: [Int])
    case courseListRemoved
    
    case removePlaceList(PlaceIds: [Int])
    case placeListRemoved
    
    case errorOccured(error: NetworkError)
}
