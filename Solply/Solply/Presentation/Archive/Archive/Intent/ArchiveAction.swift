//
//  ArchiveAction.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import Foundation

enum ArchiveAction {
    case toggleArchiveBar(archiveCategory: SolplyContentType)
    
    // api
    case fetchPlaceThumbnail
    case placeThumbnailFetched(placeArchiveThumbnails: [PlaceArchiveThumbnailDTO])
    case errorOccured(error: NetworkError)
}
