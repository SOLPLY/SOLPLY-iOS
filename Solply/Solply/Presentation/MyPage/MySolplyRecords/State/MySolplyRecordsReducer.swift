//
//  MySolplyRecordsReducer.swift
//  Solply
//
//  Created by 김승원 on 4/18/26.
//

import Foundation

enum MySolplyRecordsReducer {
    static func reduce(state: inout MySolplyRecordsState, action: MySolplyRecordsAction) {
        switch action {
        case .onAppear:
            break
            
        case .deleteRecord:
            // state의 기록 갱신
            break
            
        case .fetchMySolplyRecords:
            state.isLoading = true
            break
            
        case .fetchMySolplyRecordsSuccess(let mySolplyRecords):
            state.mySolplyRecords = mySolplyRecords
            state.isLoading = false
            
        case .fetchMySolplyRecordsFailed(let error):
            print(error)
            break
        }
    }
}
