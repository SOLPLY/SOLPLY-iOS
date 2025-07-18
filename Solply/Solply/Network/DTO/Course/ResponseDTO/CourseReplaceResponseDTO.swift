//
//  CourseReplaceResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/18/25.
//

import Foundation

struct CourseReplaceResponseDTO: ResponseModelType {
    let updatedCourseId: Int
    let updatedCourseName: String
    let isNewCourse: Bool
}
