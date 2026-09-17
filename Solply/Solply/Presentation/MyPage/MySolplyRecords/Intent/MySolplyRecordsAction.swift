//
//  MySolplyRecordsAction.swift
//  Solply
//
//  Created by 김승원 on 4/18/26.
//

import Foundation

enum MySolplyRecordsAction {
    case onAppear
    case deleteRecord(index: Int)
    
    case presentImageViewer(index: Int, imageUrls: [String?])
    case dismissImageViewer
    
    // api
    case fetchMySolplyRecords
    case fetchMySolplyRecordsSuccess(mySolplyRecords: [MySolplyRecord])
    case fetchMySolplyRecordsFailed(error: NetworkError)
    
    case removeMySolplyRecord(reviewId: Int)
    case removeMySolplyRecordSuccess(reviewId: Int)
    case removeMySolplyRecordFailed(error: NetworkError)
}
