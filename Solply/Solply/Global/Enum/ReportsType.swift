//
//  ReportsType.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

enum ReportsType: String, CaseIterable {
    case closed = "CLOSED"
    case wrongAddress = "WRONG_ADDRESS"
    case wrongPhoneNumber = "WRONG_PHONE_NUMBER"
    case wrongHours = "WRONG_HOURS"
    case wrongCategory = "WRONG_CATEGORY"
    case other = "OTHER"
    
    var title: String {
        switch self {
        case .closed: return "가게가 폐업했어요."
        case .wrongAddress: return "잘못된 주소예요."
        case .wrongPhoneNumber: return "잘못된 전화번호예요."
        case .wrongHours: return "운영시간과 휴무일이 잘못되었어요."
        case .wrongCategory: return "카테고리 분류가 잘못되었어요."
        case .other: return "기타"
        }
    }
}
