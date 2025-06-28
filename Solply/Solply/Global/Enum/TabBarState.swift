//
//  TabBarState.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import Foundation

enum TabBarState: CaseIterable, Hashable {
    case place
    case course
    
    var title: String {
        switch self {
        case .place: return "장소"
        case .course: return "코스"
        }
    }
}
