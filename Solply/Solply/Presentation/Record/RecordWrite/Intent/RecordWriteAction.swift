//
//  RecordWriteAction.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

enum RecordWriteAction {
    case selectDate(Date?)
    case selectVisitTime(RecordWriteView.VisitTime)
    case writeRecordText(String)
    
    case selectTime([(fileName: String, data: Data)])
}
