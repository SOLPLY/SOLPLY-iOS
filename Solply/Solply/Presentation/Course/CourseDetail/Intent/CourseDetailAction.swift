//
//  CourseDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

enum CourseDetailAction {
    case toggleSaveCourse
    case focusPlace(index: Int)
    case toggleSavePlace(index: Int)
    case toggleEdting
    
    case startDragging(draggedPlace: PlaceDetail)
    case whileDragging(from: Int, to: Int)
    case endDragging
    case deletePlace
    case draggedInDeleteZone
    case draggedOutDeleteZone
    
    case showToastView(ToastContent)
    
    case showAlert
    case cancelAlert
    case confirmAlert
    
    case saveCourseToCurrent
    case saveCourseAsNew
    case saveCourseCancel
    
    // api
    case fetchCourseDetail(courseId: Int)
    case courseDetailFetched(courseDetail: CourseDetailResponseDTO)
    case errorOccured(error: NetworkError)
    
    case submitCourseBookmark(courseId: Int)
    case courseBookmarkSubmited
    
    case removeCourseBookmark(courseId: Int)
    case courseBookmarkRemoved
    
    case submitPlaceBookmark(placeId: Int)
    case placeBookmarkSubmited
    
    case removePlaceBookmark(placeId: Int)
    case placeBookmarkRemoved
}
