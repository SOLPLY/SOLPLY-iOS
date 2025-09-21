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
            
        case .requestFindDirection:
            break
            
        case .toggleEdting:
            if state.isEditing {
                if state.oldPlaces != state.places {
                    state.isSaveOptionPresented = true
                } else {
                    state.isEditing = false
                }
            } else {
                state.oldPlaces.removeAll()
                state.oldPlaces = state.places
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
            state.oldPlaces.removeAll()
            
        case .saveCourseAsNew:
            // TODO: 새코스에 추가 API (Effect에서)
            state.isSaveOptionPresented = false
            state.isEditing = false
            state.oldPlaces.removeAll()
            
        case .saveCourseCancel:
            state.isSaveOptionPresented = false
            
        case .updateUserCoordinate(let latitude, let longitude):
            state.userLatitude = latitude
            state.userLongitude = longitude
            
        case .fetchCourseDetail:
            break
            
        case .courseDetailFetched(let courseDetails):
            state.courseName = courseDetails.courseName
            state.courseDescription = courseDetails.introduction
            
            let placeEntities: [PlaceDetailInCourse] = courseDetails.places.map { PlaceDetailInCourse(dto: $0) }
            state.places = placeEntities

            state.isCourseBookmarked = courseDetails.isBookmarked
            state.courseSaveSelected = courseDetails.isBookmarked

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
