//
//  PlaceComplaintAction.swift
//  Solply
//
//  Created by sun on 4/17/26.
//

import Foundation

enum PlaceComplaintAction {
    case selectComplaintType(ComplaintType)
    case updateContent(String)
    case complaint
    case complaintSuccess
    case complaintFailed(error: NetworkError)
}
