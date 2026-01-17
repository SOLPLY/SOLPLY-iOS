//
//  CourseDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

enum CourseDetailAction {
    case setDragDropState(dragDropState: DragDropState)
    
    case toggleBookmarkCourse
    case focusPlace(index: Int)
    case toggleBookmarkPlace(index: Int)

    case startEditing
    case delayEditing
    case endEditing
    
    case startDragging(draggedPlace: PlaceDetailInCourse)
    case whileDragging(destination: PlaceDetailInCourse)
    case endDragging
    case endWithoutDragging
    
    case deletePlace
    case deletePlaceFailed
    
    case droppedInDeleteZone
    case draggedInDeleteZone
    case draggedOutDeleteZone
    
    case showToastView(ToastContent)
    
    case saveCourseToCurrent
    case saveCourseAsNew
    case saveCourseCancel
    
    case requestFindDirection
    case findDirectionFinished
    case findDirection(mapRouteType: MapRouteType)
    
    case updateUserCoordinate(latitude: Double, longitude: Double)
    
    case showEditCourseNameSheet(isSheetPresented: Bool)
    case completeEditCourseInformation(courseInformation: CourseInformation)
    
    // api
    case fetchCourseDetail(courseId: Int, isCourseUpdated: Bool)
    case courseDetailFetched(courseDetail: CourseDetailResponseDTO)
    case fetchCourseDetailFailed(error: NetworkError)
    
    case submitCourseBookmark(courseId: Int)
    case courseBookmarkSubmitted
    case submitCourseBookmarkFailed(error: NetworkError)
    
    case removeCourseBookmark(courseId: Int)
    case courseBookmarkRemoved
    case removeCourseBookmarkFailed(error: NetworkError)
    
    case submitPlaceBookmark(placeId: Int)
    case placeBookmarkSubmitted
    case submitPlaceBookmarkFailed(error: NetworkError)
    
    case removePlaceBookmark(placeId: Int)
    case placeBookmarkRemoved
    case removePlaceBookmarkFailed(error: NetworkError)
    
    case updateCourseDetail(courseId: Int, request: CourseUpdateRequestDTO)
    case courseDetailUpdated(updatedCourseId: Int)
    case updateCourseDetailFailed(error: NetworkError)
    
    case submitCreateCourseDetail(request: CourseCreateRequestDTO)
    case createCourseDetailSubmitted(createdCourseId: Int)
    case submitCreateCourseDetailFailed(error: NetworkError)
}
