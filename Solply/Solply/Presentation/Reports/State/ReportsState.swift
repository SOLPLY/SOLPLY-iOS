//
//  ReportsState.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

struct ReportsState {
    var placeId: Int?
    
    var shouldGoBack: Bool = false
    var reportsStep: ReportsStep = .reportsSelect
    
    var selectedReportsType: ReportsType?
    var reportsContent: String = ""
    var attachedImageData: [(String, Data)] = []
}
