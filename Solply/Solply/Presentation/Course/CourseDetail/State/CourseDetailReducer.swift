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
            
        case .toggleSavePlace(let index):
            state.places[index].isBookmarked.toggle()
            
        case .toggleEdting:
            if state.isEditing {
                state.isSaveOptionPresented = true
            } else {
                state.isEditing = true
            }
            
            for index in state.places.indices {
                state.places[index].isFocused = false
                state.focusedPlaceIndex = -1
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
            state.isInDeleteZone = false
            
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
            
        case .showAlert:
            state.isAlertPresented = true
            
        case .cancelAlert:
            state.isAlertPresented = false
            
        case .confirmAlert:
            state.isAlertPresented = false
            
        case .saveCourseToCurrent:
            // TODO: 지금 코스에 추가 API (Effect에서)
            state.isSaveOptionPresented = false
            state.isEditing = false
            
        case .saveCourseAsNew:
            // TODO: 새코스에 추가 API (Effect에서)
            state.isSaveOptionPresented = false
            state.isEditing = false
            
        case .saveCourseCancel:
            state.isSaveOptionPresented = false
            
        case .fetchCourseDetail:
            break
            
        case .courseDetailFetched(let courseDetails):
            state.courseTitle = courseDetails.courseName
            state.courseDescription = courseDetails.introduction
            
            let placeEntities: [PlaceDetail] = courseDetails.places.map { PlaceDetail(dto: $0) }
            
            state.places = placeEntities

        case .errorOcurred(let error):
            print(error)
            break
        }
    }
}
