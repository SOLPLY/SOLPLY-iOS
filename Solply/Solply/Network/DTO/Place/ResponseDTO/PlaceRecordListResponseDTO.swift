//
//  PlaceRecordListResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 4/12/26.
//

import Foundation

struct PlaceRecordListResponseDTO: ResponseModelType {
    let reviewCount: Int
    let reviews: [RecordDTO]
}
