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
    var courseTitle: String = ""
    var courseDescription: String = ""
    var places: [PlaceDetailInCourse] = []
    var focusedPlaceIndex: Int = -1
    var courseSaveSelected: Bool = false
    var isCourseBookmarked = false
    var isEditing: Bool = false
    var canDelete: DeleteZoneState = .hidden
    var isInDeleteZone: Bool = false
    
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
    var toastContent: ToastContent?
    
    var isAlertPresented: Bool = false
    var isSaveOptionPresented: Bool = false
    
    var draggedPlace: PlaceDetailInCourse?
}
