//
//  MySolplyRecordsResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 5/7/26.
//

import Foundation

struct MySolplyRecordsResponseDTO: ResponseModelType {
    let reviewCount: Int
    let reviews: [MySolplyRecordDTO]
}

struct MySolplyRecordDTO: ResponseModelType {
    let reviewId: Int
    let placeId: Int
    let content: String
    let visitedAt: String
    let visitTimeSlot: String
    let imageUrls: [String]
}
