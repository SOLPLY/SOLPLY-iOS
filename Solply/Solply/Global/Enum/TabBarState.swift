//
//  TabBarState.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

enum TabBarState: CaseIterable, Hashable {
    case place
    case course
    case bookmark
    case myPage
    
    var title: String {
        switch self {
        case .place: return "장소"
        case .course: return "코스"
        case .bookmark: return "수집함"
        case .myPage: return "마이페이지"
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .place: return .placeNavIcon
        case .course: return .courseNavIcon
        case .bookmark: return .bookmarkNavIcon
        case .myPage: return .myNavIcon
        }
    }
}
