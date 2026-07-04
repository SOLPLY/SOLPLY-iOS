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
    let placeName: String
    let mainTag: String
    let content: String
    let visitedAt: String
    let visitTimeSlot: VisitTime
    let imageUrls: [String]
}
