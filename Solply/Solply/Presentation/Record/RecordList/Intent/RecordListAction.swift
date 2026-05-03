//
//  RecordListAction.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import Foundation

enum RecordListAction {
    case onAppear
    
    case presentImageViewer(index: Int, imageUrls: [String?])
    case dismissImageViewer
    
    // api
    case fetchPlaceRecordList
    case fetchPlaceRecordListSuccess(records: [Record])
    case fetchPlaceRecordListFailed(error: NetworkError)
}
    
