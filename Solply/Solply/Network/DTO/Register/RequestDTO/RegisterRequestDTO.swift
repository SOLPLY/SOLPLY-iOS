//
//  RegisterRequestDTO.swift
//  Solply
//
//  Created by 김승원 on 11/2/25.
//

import Foundation

struct RegisterRequestDTO: RequestModelType {
    let placeName: String
    let address: String
    let mainTagId: Int
    let subTagAIds: [Int]
    let subTagBIds: [Int]
    let reason: String?
    let images: [RegisterImage]?
}

struct RegisterImage: RequestModelType {
    let displayOrder: Int
    let tempFileKey: String
}
