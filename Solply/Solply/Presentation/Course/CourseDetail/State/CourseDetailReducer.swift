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
        case .setDragDropState(let dragDropState):
            state.dragDropState = dragDropState
            
        case .toggleBookmarkCourse:
            state.courseBookmarkSelected.toggle()
            
        case .focusPlace(let index):
            state.focusedPlaceIndex = state.focusedPlaceIndex == index ? -1 : index
            
            for index in state.places.indices {
                state.places[index].isFocused = (index == state.focusedPlaceIndex)
            }
            
        case .toggleBookmarkPlace(let index):
            state.places[index].isBookmarked.toggle()
            
        case .requestFindDirection:
            break
            
        case .startEditing:
            break
            
        case .delayEditing:
            state.oldPlaces.removeAll()
            state.oldPlaces = state.places
            state.oldCourseName = state.courseName
            state.oldCourseDescription = state.courseDescription
            state.isEditing = true
            
        case .endEditing:
            if state.oldPlaces != state.places
                || state.oldCourseName != state.courseName
                || state.oldCourseDescription != state.courseDescription
            {
                state.isSaveOptionPresented = true
            } else {
                state.isEditing = false
            }
            
        case .startDragging(draggedPlace: let draggedPlace):
            switch state.dragDropState {
            case .prepared:
                state.draggedPlace = draggedPlace
                state.canDelete = true
                state.dragDropState = .dragging
            case .dragging, .completed:
                state.dragDropState = .prepared
            }
            
        case .whileDragging(let destination):
            if let draggedPlace = state.draggedPlace,
               let fromIndex = state.places.firstIndex(of: draggedPlace),
               let toIndex = state.places.firstIndex(of: destination) {
                
                guard state.draggedPlace != nil,
                      fromIndex < state.places.count,
                      toIndex < state.places.count,
                      fromIndex != toIndex else { return }
                
                let movedPlace = state.places.remove(at: fromIndex)
                state.places.insert(movedPlace, at: toIndex)
            }
            
        case .endDragging:
            state.dragDropState = .completed
            state.draggedPlace = nil
            state.canDelete = false
            state.isInDeleteZone = false
            
        case .deletePlace:
            guard let draggedPlace = state.draggedPlace else { return }
            state.dragDropState = .completed
            
            if let index = state.places.firstIndex(of: draggedPlace) {
                state.places.remove(at: index)
                state.canDelete = false
                state.draggedPlace = nil
            }
            
            state.isInDeleteZone = false
            
        case .droppedInDeleteZone:
            break
            
        case .draggedInDeleteZone:
            state.isInDeleteZone = true
            
        case .draggedOutDeleteZone:
            state.isInDeleteZone = false
            
        case .showToastView(let toastContent):
            state.toastContent = toastContent
            state.draggedPlace = nil
            state.canDelete = false
            state.isInDeleteZone = false
            
        case .saveCourseToCurrent:
            state.isSaveOptionPresented = false
            state.isEditing = false
            state.oldPlaces.removeAll()
            
        case .saveCourseAsNew:
            state.isSaveOptionPresented = false
            state.isEditing = false
            state.oldPlaces.removeAll()
            
        case .saveCourseCancel:
            state.isSaveOptionPresented = false
            
        case .updateUserCoordinate(let latitude, let longitude):
            state.userLatitude = latitude
            state.userLongitude = longitude
            
        case .showSheet(let isSheetPresented):
            state.isSheetPresented = isSheetPresented
            
        case .completeEditCourseInformation(let courseInformation):
            state.courseName = courseInformation.courseName
            state.courseDescription = courseInformation.courseDescription
            
        case .fetchCourseDetail:
            break
            
        case .courseDetailFetched(let courseDetails):
            state.courseName = courseDetails.courseName
            state.courseDescription = courseDetails.introduction
            
            let placeEntities: [PlaceDetailInCourse] = courseDetails.places.map { PlaceDetailInCourse(dto: $0) }
            state.places = placeEntities

            state.isCourseBookmarked = courseDetails.isBookmarked
            state.courseBookmarkSelected = courseDetails.isBookmarked

        case .errorOccured(let error):
            print(error)
            break
            
        case .submitCourseBookmark:
            break
            
        case .courseBookmarkSubmitted:
            print("저장 완료")
            break
            
        case .removeCourseBookmark:
            break
            
        case .courseBookmarkRemoved:
            print("저장 취소 완료")
            break
            
        case .submitPlaceBookmark:
            break
            
        case .placeBookmarkSubmitted:
            print("장소 저장 완료")
            break
            
        case .removePlaceBookmark:
            break
            
        case .placeBookmarkRemoved:
            print("장소 저장 취소 완료")
            break
            
        case .updateCourseDetail:
            break
            
        case .courseDetailUpdated(updatedCourseId: let updatedCourseId):
            state.updatedCourseId = updatedCourseId
            break
            
        case .submitCreateCourseDetail:
            break
            
        case .createCourseDetailSubmitted(createdCourseId: let createdCourseId):
            state.updatedCourseId = createdCourseId
        }
    }
}
