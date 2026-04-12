//
//  RecordWriteState.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

struct RecordWriteState {
    var shouldGoBack: Bool = false
    
    var selectedDate: Date? = nil
    var selectedVisitTime: VisitTime? = nil
    var recordText: String = ""
    var selectedPhotos: [(fileName: String, data: Data)] = []
    
    var isSubmitButtonEnabled: Bool {
        selectedDate != nil
        && selectedVisitTime != nil
        && !recordText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
