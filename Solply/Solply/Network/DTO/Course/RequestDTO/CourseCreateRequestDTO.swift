//
//  CourseCreateRequestDTO.swift
//  Solply
//
//  Created by 김승원 on 7/18/25.
//

import Foundation

struct CourseCreateRequestDTO: RequestModelType {
    let courseName: String
    let courseDescription: String
    let courseTagId: Int
    let places: [PlaceOrderDTO]
    let isCourseNameUniqueRequired: Bool
}
