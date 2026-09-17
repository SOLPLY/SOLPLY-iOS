//
//  ReportsAction.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

enum ReportsAction {
    case setPlaceId(placeId: Int)
    
    case selectReportsType(reportsType: ReportsType)
    case changeReportsStep(reportsStep: ReportsStep)
    case editReportsContent(reportsContent: String)
    case attachReportsPhoto(imageData: [(String, Data)])
    
    // api
    case errorOccured(error: NetworkError)
    
    case submitReports(placeId: Int, request: ReportsRequestDTO)
    case reportsSubmitted
    case reportsFailed(error: NetworkError)
}
