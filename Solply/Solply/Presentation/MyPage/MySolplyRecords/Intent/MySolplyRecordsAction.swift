//
//  MySolplyRecordsAction.swift
//  Solply
//
//  Created by 김승원 on 4/18/26.
//

import Foundation

enum MySolplyRecordsAction {
    case onAppear
    case deleteRecord
    
    // api
    case fetchMySolplyRecords
    case fetchMySolplyRecordsSuccess(mySolplyRecords: [MySolplyRecord])
    case fetchMySolplyRecordsFailed(error: NetworkError)
}
