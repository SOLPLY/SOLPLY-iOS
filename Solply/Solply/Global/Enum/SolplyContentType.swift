//
//  SolplyContentType.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum SolplyContentType: CaseIterable{
    case place
    case course
    
    var title: String {
        switch self {
        case .place: return "장소"
        case .course: return "코스"
        }
    }
}
