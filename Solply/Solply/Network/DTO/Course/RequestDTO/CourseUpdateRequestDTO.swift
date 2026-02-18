//
//  CourseUpdateRequestDTO.swift
//  Solply
//
//  Created by 김승원 on 7/18/25.
//

import Foundation

struct CourseUpdateRequestDTO: RequestModelType {
    let courseName: String
    let courseDescription: String
    let courseTagId: Int
    let places: [PlaceOrderDTO]
}

// MARK: - PlaceOrder

struct PlaceOrderDTO: RequestModelType {
    let placeId: Int
    let placeOrder: Int
}
