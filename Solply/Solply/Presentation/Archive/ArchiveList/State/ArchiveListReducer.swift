//
//  ArchiveListReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

enum ArchiveListReducer {
    @MainActor static func reduce(state: inout ArchiveListState, action: ArchiveListAction) {
        switch action {
        case .toggleCourseArchiveList(let courseId):
            if state.selectedCourseIds.contains(courseId) {
                state.selectedCourseIds.remove(courseId)
            } else {
                state.selectedCourseIds.insert(courseId)
            }
            
        case .togglePlaceArchiveList(let placeId):
            if state.selectedPlaceIds.contains(placeId) {
                state.selectedPlaceIds.remove(placeId)
            } else {
                state.selectedPlaceIds.insert(placeId)
            }
            
        case .toggleSelect:
            state.activeDelete = true
            
        case .toggleCancel:
            state.selectedPlaceIds.removeAll()
            state.selectedCourseIds.removeAll()
            state.activeDelete = false
            
        case .showAlert:
            state.isPresented = true
            
        case .alertCancel:
            state.isPresented = false
            
        case .alertDelete:
            state.isPresented = false
            state.activeDelete = false
            
        
            
        case .fetchCourseList:
            break
            
        case .courseListFetched(let courseLists):
            state.courses = courseLists
            print(courseLists)
            
        case .removeCourseList:
            break
            
        case .courseListRemoved:
            state.courses.removeAll { course in
                state.selectedCourseIds.contains(course.courseId)
            }

            state.selectedCourseIds.removeAll()
            state.activeDelete = false
            
        case .removePlaceList:
            print("장소 삭제")
            break
            
        case .placeListRemoved:
            print("장소 삭제")
            state.places.removeAll() { place in
                state.selectedPlaceIds.contains(place.placeId)
            }
            
            state.selectedPlaceIds.removeAll()
            state.activeDelete = false
            
        case .fetchPlaceList:
            break
            
        case .placeListFetched(let placeList):
            state.places = placeList
            
        case .errorOccured(let error):
            print(error)
            break
        }
    }
}
