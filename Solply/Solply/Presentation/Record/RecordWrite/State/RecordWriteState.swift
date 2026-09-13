//
//  RecordWriteState.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

struct RecordWriteState {
    private let minimumRecordTextLength: Int = 10
    
    var isLoading: Bool = false
    var shouldGoBack: Bool = false
    
    var selectedDate: Date? = nil
    var selectedVisitTime: VisitTime? = nil
    var recordText: String = ""
    var selectedPhotos: [(fileName: String, data: Data)] = []
    
    var isSubmitButtonEnabled: Bool {
        let trimmedText = recordText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return selectedDate != nil
            && selectedVisitTime != nil
            && trimmedText.count >= minimumRecordTextLength
    }
}
