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
            state.isCourseBookmarkSelected.toggle()
            
        case .focusPlace(let index):
            state.focusedPlaceIndex = state.focusedPlaceIndex == index ? -1 : index
            
            for index in state.places.indices {
                state.places[index].isFocused = (index == state.focusedPlaceIndex)
            }
            
        case .toggleBookmarkPlace(let index):
            state.places[index].isBookmarked.toggle()
            
        case .requestFindDirection:
            state.isFindDirectionDialogPresented = true
            
        case .findDirectionFinished:
            state.isFindDirectionDialogPresented = false
            
        case .findDirection:
            break
            
        case .startEditing:
            break
            
        case .delayEditing:
            state.oldPlaces.removeAll()
            state.oldPlaces = state.places
            state.oldCourseName = state.courseName
            state.oldCourseDescription = state.courseDescription
            state.isCourseEditing = true
            
        case .endEditing:
            if state.isCourseChanged {
                state.isSaveOptionPresented = true
            } else {
                state.isCourseEditing = false
            }
            
        case .startDragging(draggedPlace: let draggedPlace):
            switch state.dragDropState {
            case .prepared:
                state.draggedPlace = draggedPlace
                state.canDeletePlace = true
                state.dragDropState = .dragging
            case .dragging, .completed:
                state.dragDropState = .prepared
            }
            
        case .whileDragging(let destination):
            guard let draggedPlace = state.draggedPlace,
                  let fromIndex = state.places.firstIndex(of: draggedPlace),
                  let toIndex = state.places.firstIndex(of: destination),
                  fromIndex != toIndex else { return }
            
            let movedPlace = state.places.remove(at: fromIndex)
            state.places.insert(movedPlace, at: toIndex)
            
        case .endDragging:
            state.dragDropState = .completed
            state.draggedPlace = nil
            state.canDeletePlace = false
            state.isPlaceInDeleteZone = false
            
        case .endWithoutDragging:
            state.dragDropState = .prepared
            state.draggedPlace = nil
            state.canDeletePlace = false
            state.isPlaceInDeleteZone = false
            
        case .deletePlace:
            guard let draggedPlace = state.draggedPlace else { return }
            state.dragDropState = .completed
            
            if let index = state.places.firstIndex(of: draggedPlace) {
                state.places.remove(at: index)
            }
            
            state.draggedPlace = nil
            state.canDeletePlace = false
            state.isPlaceInDeleteZone = false
            
        case .deletePlaceFailed:
            state.dragDropState = .completed
            state.draggedPlace = nil
            state.canDeletePlace = false
            state.isPlaceInDeleteZone = false
            
        case .droppedInDeleteZone:
            break
            
        case .draggedInDeleteZone:
            state.isPlaceInDeleteZone = true
            
        case .draggedOutDeleteZone:
            state.isPlaceInDeleteZone = false
            
        case .showToastView(let toastContent):
            state.toastContent = toastContent
            state.draggedPlace = nil
            state.canDeletePlace = false
            state.isPlaceInDeleteZone = false
            
        case .saveCourseToCurrent:
            state.isSaveOptionPresented = false
            state.isCourseEditing = false
            
        case .saveCourseAsNew:
            state.isSaveOptionPresented = false
            state.isCourseEditing = false
            
        case .saveCourseCancel:
            state.isSaveOptionPresented = false
            
        case .updateUserCoordinate(let latitude, let longitude):
            state.userLatitude = latitude
            state.userLongitude = longitude
            
        case .showEditCourseNameSheet(let isSheetPresented):
            state.isEditCourseNameSheetPresented = isSheetPresented
            
        case .completeEditCourseInformation(let courseInformation):
            state.courseName = courseInformation.courseName
            state.courseDescription = courseInformation.courseDescription
            
        // api
            
        case .fetchCourseDetail(_, let isCourseUpdated):
            if !isCourseUpdated {
                state.isCourseDetailLoading = true
            }
            
        case .courseDetailFetched(let courseDetails):
            state.isCourseDetailLoading = false
            state.courseName = courseDetails.courseName
            state.courseDescription = courseDetails.introduction
            state.courseTag = CourseTagType.init(rawValue: courseDetails.courseTagName) ?? .daily
            
            let placeEntities: [PlaceDetailInCourse] = courseDetails.places.map { PlaceDetailInCourse(dto: $0) }
            state.places = placeEntities

            state.isCourseBookmarked = courseDetails.isBookmarked
            state.isCourseBookmarkSelected = courseDetails.isBookmarked
            
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
            state.oldPlaces.removeAll()
            state.oldCourseName = ""
            state.oldCourseDescription = ""
            
        case .updateCourseDetailSuccess:
            state.oldPlaces.removeAll()
            state.oldCourseName = ""
            state.oldCourseDescription = ""
            
        case .submitCreateCourseDetail:
            break
            
        case .submitCreateCourseDetailSuccess:
            break
            
        // errors
            
        case .fetchCourseDetailFailed(let error):
            state.isCourseDetailLoading = true
            print(error)
            
        case .submitCourseBookmarkFailed(let error):
            print(error)
            
        case .removeCourseBookmarkFailed(let error):
            print(error)
            
        case .submitPlaceBookmarkFailed(let error):
            print(error)
            
        case .removePlaceBookmarkFailed(let error):
            print(error)
            
        case .updateCourseDetailFailed(let error):
            print(error)
            
        case .submitCreateCourseDetailFailed(let error):
            print(error)
        }
    }
}
