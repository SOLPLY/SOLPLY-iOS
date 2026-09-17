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

        case .complaint:
            break

        case .complaintSuccess:
            state.showComplaintCompleteModal = true

        case .complaintFailed(let error):
            state.error = error
        }
    }
}
