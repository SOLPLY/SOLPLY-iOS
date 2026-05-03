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
            
        case .selectPhotos(let photos):
            state.selectedPhotos = photos
            
        case .registerRecordButtonTapped:
            break
            
        // api
        case .submitPlaceRecordWrite:
            state.isLoading = true
            break
            
        case .submitPlaceRecordWriteSuccess:
            state.shouldGoBack = true
            state.isLoading = false
            
        case .submitPlaceRecordWriteFailed(let error):
            state.isLoading = false
            print(error)
        }
    }
}
