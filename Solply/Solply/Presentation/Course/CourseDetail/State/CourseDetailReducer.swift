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
            
            for i in state.places.indices {
                state.places[i].isFocused = (i == state.focusedPlaceIndex)
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
        }
    }
}
