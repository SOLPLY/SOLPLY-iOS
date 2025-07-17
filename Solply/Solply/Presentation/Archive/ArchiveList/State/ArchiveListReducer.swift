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
        case .toggleArchiveList(let courseId):
            if state.selectedCourseIds.contains(courseId) {
                state.selectedCourseIds.remove(courseId)
            } else {
                state.selectedCourseIds.insert(courseId)
            }
            
        case .toggleSelect:
            state.activeDelete = true
            
        case .toggleCancel:
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
            
        case .CourseListRemoved:
            state.courses.removeAll { course in
                state.selectedCourseIds.contains(course.courseId)
            }

            state.selectedCourseIds.removeAll()
            state.activeDelete = false
            
        case .errorOccured(let error):
            print(error)
            break
        }
    }
}
