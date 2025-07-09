//
//  CourseDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

enum CourseDetailAction {
    case toggleSaveCourse
    case focusPlace(index: Int)
    case toggleSavePlace(index: Int)
    
    case fetchCourseDetailData
    case courseDetailDataFetched(Course)
}
