//
//  PlaceComplaintReducer.swift
//  Solply
//
//  Created by sun on 4/16/26.
//

import Foundation

enum PlaceComplaintReducer {
    static func reduce(state: inout PlaceComplaintState, action: PlaceComplaintAction) {
        switch action {
        case .selectComplaintType(let complaintType):
            state.selectedComplaintType = complaintType
            
            if complaintType != .others {
                state.content = ""
            }
            
        case .updateContent(let text):
            state.content = String(text.prefix(200))
            
        case .complaint:
            break
            
        case .complaintSuccess:
            state.showComplaintCompleteModal = true
            break
            
        case .complaintFailed(let error):
            print(error)
            break
        }
    }
}
