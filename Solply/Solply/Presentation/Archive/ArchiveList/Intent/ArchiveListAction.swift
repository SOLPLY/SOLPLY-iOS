//
//  ArchiveListAction.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

enum ArchiveListAction {
    case toggleArchiveList(index: Int)
    case toggleSelect
    case toggleCancel
    
    case showAlert
    case alertCancel
    case alertDelete
    
    // api
    case fetchCourseList(townId: Int, placeId: Int?)
    case courseListFetched(courseLists: [CourseArchiveDTO])
    case errorOccured(error: NetworkError)
}
