//
//  PlaceRecordWriteRequestDTO.swift
//  Solply
//
//  Created by 김승원 on 4/12/26.
//

import Foundation

struct PlaceRecordWriteRequestDTO: RequestModelType {
    let placeId: Int
    let visitedAt: String
    let visitTimeSlot: VisitTime
    let content: String
    let imageKeys: [String]
}
