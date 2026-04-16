//
//  PlaceComplaintState.swift
//  Solply
//
//  Created by sun on 4/16/26.
//

import Foundation

struct PlaceComplaintState {
    var selectedComplaintType: ComplaintType?
    var content: String = ""
    var showComplaintCompleteModal: Bool = false
    var error: NetworkError?
}
