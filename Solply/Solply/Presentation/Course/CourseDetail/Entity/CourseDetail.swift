//
//  CourseDetail.swift
//  Solply
//
//  Created by 김승원 on 7/11/25.
//

import Foundation

struct CourseDetail {
    let courseId: Int
    let courseName: String
    let introduction: String
    var places: [PlaceDetailInCourse]
}
