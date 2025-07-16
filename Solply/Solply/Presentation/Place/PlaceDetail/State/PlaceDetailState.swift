//
//  PlaceDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

struct PlaceDetailState {
    var addButtonSelected: Bool = false
    var saveButtonSelected: Bool = false
    var saveButtonEnabled: Bool = true
    var findDirectionEnabled: Bool = true
    
    var courses: [CourseArchiveDTO] = []
    
    var selectedCourseIndex: Int = -1
    
    var toastContent: ToastContent?
}
