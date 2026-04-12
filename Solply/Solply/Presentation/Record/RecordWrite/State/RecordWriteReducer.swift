//
//  RecordWriteReducer.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

enum RecordWriteReducer {
    
    static func reduce(state: inout RecordWriteState, action: RecordWriteAction) {
        switch action {
        case .selectDate(let date):
            state.selectedDate = date
            
        case .selectVisitTime(let time):
            state.selectedVisitTime = time
            
        case .writeRecordText(let text):
            state.recordText = text
            
        case .selectTime(let photos):
            state.selectedPhotos = photos
        }
    }
}
