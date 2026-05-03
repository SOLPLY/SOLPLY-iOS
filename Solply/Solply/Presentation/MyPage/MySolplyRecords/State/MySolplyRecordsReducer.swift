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
            state.mySolplyRecords = MySolplyRecord.mock
        case .deleteRecord:
            // state의 기록 갱신
            break
        }
    }
}
