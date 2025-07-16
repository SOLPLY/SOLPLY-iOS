//
//  CourseDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

struct CourseDetailState {
    var isLoading: Bool = false
    var courseTitle: String = ""
    var courseDescription: String = ""
    var places: [PlaceDetail] = []
    var focusedPlaceIndex: Int = -1
    var courseSaveSelected: Bool = false
    var isEditing: Bool = false
    var canDelete: DeleteZoneState = .hidden
    var isInDeleteZone: Bool = false
    
    var toastContent: ToastContent?
    
    var isAlertPresented: Bool = false
    var isSaveOptionPresented: Bool = false
    
    var draggedPlace: PlaceDetail?
}
