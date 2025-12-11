//
//  AddPlaceCourseInformation.swift
//  Solply
//
//  Created by 김승원 on 12/11/25.
//

import Foundation

struct AddPlaceCourseInformation: Equatable {
    let courseId: Int
    let courseName: String
}

extension AddPlaceCourseInformation {
    init(dto: CourseAddPlaceResponseDTO) {
        self.courseId = dto.courseId
        self.courseName = dto.courseName
    }
}
