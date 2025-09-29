//
//  CourseDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

struct CourseDetailState {
    var updatedCourseId: Int = -1
    
    var isLoading: Bool = false
    var isSheetPresented: Bool = false
    
    var courseName: String = ""
    var courseDescription: String = ""
    var oldCourseName: String = ""
    var oldCourseDescription: String = ""
    
    var places: [PlaceDetailInCourse] = []
    var oldPlaces: [PlaceDetailInCourse] = []
    
    var focusedPlaceIndex: Int = -1
    var courseBookmarkSelected: Bool = false
    var isCourseBookmarked: Bool = false
    var isEditing: Bool = false
    var canDelete: DeleteZoneState = .hidden
    var isInDeleteZone: Bool = false
    
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
    var toastContent: ToastContent?
    
    var isSaveOptionPresented: Bool = false
    
    var draggedPlace: PlaceDetailInCourse?
}
