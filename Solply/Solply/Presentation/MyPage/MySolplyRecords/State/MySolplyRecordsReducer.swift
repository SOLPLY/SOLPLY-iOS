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
            break
            
        case .presentImageViewer(let index, let imageUrls):
            state.imageViewerItem = ImageViewerItem(
                selectedIndex: index,
                imageUrls: imageUrls
            )
            
        case .dismissImageViewer:
            state.imageViewerItem = nil
            
        case .fetchMySolplyRecords:
            state.isLoading = true
            break
            
        case .fetchMySolplyRecordsSuccess(let mySolplyRecords):
            state.mySolplyRecords = mySolplyRecords
            state.isLoading = false
            
        case .fetchMySolplyRecordsFailed(let error):
            print(error)
            break
            
        case .removeMySolplyRecord:
            break
            
        case .removeMySolplyRecordSuccess(let reviewId):
            state.mySolplyRecords.removeAll { $0.id == reviewId }
            break
            
        case .removeMySolplyRecordFailed(let error):
            print(error)
            break
        }
    }
}
