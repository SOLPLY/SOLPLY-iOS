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
    
    case startDragging(draggedPlace: Place)
    case whileDragging(from: Int, to: Int)
    case endDragging
    case deletePlace
    case draggedInDeleteZone
    case draggedOutDeleteZone
    
    case showToastView(ToastContent)
    
    case showAlert
    case cancelAlert
    case confirmAlert
    
    case fetchCourseDetailData
    case courseDetailDataFetched(Course)
}
