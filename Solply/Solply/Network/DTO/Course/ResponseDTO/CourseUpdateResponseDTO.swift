//
//  CourseUpdateResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/18/25.
//

import Foundation

struct CourseUpdateResponseDTO: ResponseModelType {
    let updatedCourseId: Int
    let updatedCourseName: String
    let updatedCourseDescription: String
    let isNewCourse: Bool
}
