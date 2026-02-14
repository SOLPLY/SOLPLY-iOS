//
//  CourseDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

struct CourseDetailState {
    var isCourseDetailLoading: Bool = false
    
    var isFindDirectionDialogPresented: Bool = false
    var isSaveOptionPresented: Bool = false
    var isEditCourseNameSheetPresented: Bool = false
    
    var draggedPlace: PlaceDetailInCourse?
    var dragDropState: DragDropState = .prepared
    
    var updatedCourseId: Int = -1 
    
    var courseName: String = ""
    var courseDescription: String = ""
    var oldCourseName: String = ""
    var oldCourseDescription: String = ""
    
    var courseTag: CourseTagType? = nil
    
    var places: [PlaceDetailInCourse] = []
    var oldPlaces: [PlaceDetailInCourse] = []
    
    var focusedPlaceIndex: Int = -1
    var isCourseBookmarkSelected: Bool = false
    var isCourseBookmarked: Bool = false
    var isCourseEditing: Bool = false
    var canDeletePlace: Bool = false
    var isPlaceInDeleteZone: Bool = false
    
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
    var toastContent: ToastContent?
    
    var isCourseNameUniqueRequired: Bool {
        return oldCourseName == courseName
    }
}
