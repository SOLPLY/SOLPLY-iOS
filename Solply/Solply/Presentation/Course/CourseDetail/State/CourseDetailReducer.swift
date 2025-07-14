//
//  CourseDetailReducer.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

enum CourseDetailReducer {
    static func reduce(state: inout CourseDetailState, action: CourseDetailAction) {
        switch action {
        case .toggleSaveCourse:
            state.courseSaveSelected.toggle()
            
        case .focusPlace(let index):
            state.focusedPlaceIndex = state.focusedPlaceIndex == index ? -1 : index
            
            for index in state.places.indices {
                state.places[index].isFocused = (index == state.focusedPlaceIndex)
            }
            
        case .fetchCourseDetailData:
            state.isLoading = true
            
        case .courseDetailDataFetched(let course):
            state.isLoading = false
            state.courseTitle = course.courseTitle
            state.courseDescription = course.courseDescription
            state.places = course.places
            
        case .toggleSavePlace(let index):
            state.places[index].isSaved.toggle()
            
        case .toggleEdting:
            state.isEditing.toggle()
            state.focusedPlaceIndex = -1
            state.canDelete = .hidden
            
            for index in state.places.indices {
                state.places[index].isFocused = false
            }
            
        case .startDragging(draggedPlace: let draggedPlace):
            state.draggedPlace = state.canDelete == .dismissed ? nil : draggedPlace
            state.canDelete = (state.canDelete == .dismissed ? .hidden : .active)
            
        case .whileDragging(from: let fromIndex, to: let toIndex):
            guard state.draggedPlace != nil,
                  fromIndex < state.places.count,
                  toIndex < state.places.count,
                  fromIndex != toIndex else { return }
            
            let movedPlace = state.places.remove(at: fromIndex)
            state.places.insert(movedPlace, at: toIndex)
            
        case .endDragging:
            state.draggedPlace = nil
            state.canDelete = .dismissed
            
        case .deletePlace:
            guard let place = state.draggedPlace else { return }
            
            if let index = state.places.firstIndex(of: place) {
                state.places.remove(at: index)
                state.canDelete = .dismissed
                state.draggedPlace = nil
            }
            
            state.isInDeleteZone = false
            
        case .draggedInDeleteZone:
            state.isInDeleteZone = true
            
        case .draggedOutDeleteZone:
            state.isInDeleteZone = false
            
        case .showToastView(let toastContent):
            state.toastContent = toastContent
            state.draggedPlace = nil
            state.canDelete = .dismissed
            state.isInDeleteZone = false
        }
    }
}
