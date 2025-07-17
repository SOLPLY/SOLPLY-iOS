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
    
    case removeCourseList(CourseIds: [Int])
    case CourseListRemoved
    
    case removePlaceList(PlaceIds: [Int])
    case PlaceListRemoved
    
    case errorOccured(error: NetworkError)
}
