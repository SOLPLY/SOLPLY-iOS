//
//  ReportsAction.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

enum ReportsAction {
    case selectReportsType(reportsType: ReportsType)
    case changeReportsStep(reportsStep: ReportsStep)
    case editReportsContent(reportsContent: String)
}
