//
//  PlaceArchiveResponseDTO.swift
//  Solply
//
//  Created by LEESOOYONG on 7/17/25.
//

import Foundation

struct PlaceArchiveResponseDTO: ResponseModelType {
    let plcaes: [PlaceArchiveDTO]
}

struct PlaceArchiveDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
}
