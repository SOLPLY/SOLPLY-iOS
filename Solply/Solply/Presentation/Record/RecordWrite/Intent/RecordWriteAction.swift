//
//  RecordWriteAction.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

enum RecordWriteAction {
    case selectDate(Date?)
    case selectVisitTime(VisitTime)
    case writeRecordText(String)
    case selectPhotos([(fileName: String, data: Data)])
    
    case registerRecordButtonTapped
    
    // api
    case submitPlaceRecordWrite(request: PlaceRecordWriteRequestDTO)
    case submitPlaceRecordWriteSuccess
    case submitPlaceRecordWriteFailed(error: NetworkError)
}
