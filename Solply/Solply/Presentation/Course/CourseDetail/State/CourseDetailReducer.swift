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
            state.saveButtonSelected.toggle()
        }
    }
}
