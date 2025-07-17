//
//  CourseAddPlaceResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 7/17/25.
//

import Foundation

struct CourseAddPlaceResponseDTO: ResponseModelType {
    let courseId: Int
    let courseName: String
    let isNewCourse: Bool
    let addedPlaceInfo: AddedPlaceInformationDTO
}

struct AddedPlaceInformationDTO: Decodable {
    let placeId: Int
    let placeOrder: Int
}
