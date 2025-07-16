//
//  PlaceArchiveResponseDTO.swift
//  Solply
//
//  Created by LEESOOYONG on 7/16/25.
//

import Foundation

struct PlaceArchiveThumbnailResponseDTO: ResponseModelType {
    let folderThumbnailList: [PlaceArchiveThumbnailDTO]
}

struct PlaceArchiveThumbnailDTO: ResponseModelType {
    let townId: Int?
    let townName: String?
    let folderThumbnailUrl: String?
}
