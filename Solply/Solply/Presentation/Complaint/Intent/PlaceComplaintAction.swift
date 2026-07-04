//
//  PlaceComplaintAction.swift
//  Solply
//
//  Created by sun on 4/17/26.
//

enum PlaceComplaintAction {
    case selectComplaintType(ComplaintType)
    case complaint
    case complaintSuccess
    case complaintFailed(error: NetworkError)
}
