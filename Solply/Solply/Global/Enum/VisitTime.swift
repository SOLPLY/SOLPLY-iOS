//
//  VisitTime.swift
//  Solply
//
//  Created by sun on 4/11/26.
//

import Foundation

enum VisitTime: String, CaseIterable, ResponseModelType, RequestModelType {
    case morning = "MORNING"
    case afternoon = "AFTERNOON"
    case evening = "EVENING"
}

extension VisitTime {
    var title: String {
        switch self {
        case .morning: return "오전"
        case .afternoon: return "오후"
        case .evening: return "저녁"
        }
    }
}
